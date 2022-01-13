---
last_modified_at: 2019-09-12 22:38:48+0200
---

I was recently hired by a multiproduct company in Barcelona.
My first assignment was to create the new environments,
workflows, and deployment processes.

Since this was a cross-product solution
the priority was flexibility.
Their entire codebase was managed by TortoiseSVN, so first, we needed to migrate from SVN to GIT.

## The Official Way

First create the authors file, by iterating through SVN logs, and update it with the correct information:

```sh
svn log --quiet svn://domain.com/svn/ | grep -E "r[0-9]+ \| .+ \|" | cut -d'|' -f2 | sed 's/^ //' | sort | uniq > authors.txt
```

Finally migrate clone with:

```sh
git svn clone svn://domain.com/svn/trunk/Implementation/site/ --authors-file ../authors.txt --no-metadata --prefix "" -s my_project
```

You can also manually configure a GIT repo pointing to a non-standard setup by telling `git-svn` about the specific location as such:

```sh
git svn clone svn://internal-repo/Project Project --trunk=trunk --branches=maintenance/* --prefix=git-svn/
```
Here we tell `git-svn` that `trunk` is the `trunk` directory and `maintenance` is the `branches` directory.


`git svn clone` starts pulling down code right away, which in most cases would work just fine. But, if you are working on a large repository it can take a few hours to fetch the code from trunk and all the branches.

## The Better Approach

I decided to implement, a better approach, to initialize a repository from the scratch.
This way configuration is not that aggressive and because the repository was about 24GB was tedious to download everything right away.

```sh
git svn init svn://domain.com/svn/trunk/Implementation/site/ --prefix=origin/ my_project
```

note about prefix: https://stackoverflow.com/questions/4986379/how-can-i-change-the-prefix-mapping-in-a-git-svn-repository

This generates a folder with the correct .git folder.
Open `.git/config` and add this 3 lines to the [core] section.

```
ignorecase = true
precomposeunicode = false
authorsfile = .git/svn/authors.txt
```

Instead of all branches, let’s say we just want to pull the branch named `branch1`.
You would want to modify the line as below:

```
[svn-remote "svn"]
  url = https://git-svn-sample-project.googlecode.com/svn
  fetch = trunk:refs/remotes/git-svn/trunk
  branches = branches/{branch1}:refs/remotes/git-svn/*
```

We replaced `*` with `{branch1}`, this way we tell `git-svn` to only fetch `branch1`. You can add more branches by adding the branch name in a comma-separated list such as `{branch1,branch4}`.

We're ready to go.
```sh
git svn fetch
```

Now you should a log like this (yes, that's a real commit)

```
commit 85555cf9c8ddf64ae50ad03ec7a5577ee1cc032d
Author: brian <brian@39ca4a87-b920-0410-bd69-b12db43a2cee>
Date:   Mon Sep 18 22:01:06 2017 +0000

    Flashcards!

    git-svn-id: svn://domain.com/svn/trunk/Implementation/site@17802 39ca4a87-b920-0410-bd69-b12db43a2cee
```

You can also remove metadata but as the official documentation says:

```
This option is NOT recommended as it makes it difficult to track down old references to SVN revision numbers in existing documentation, bug reports, and archives. If you plan to eventually migrate from SVN to git and are certain about dropping SVN history, consider git-filter-branch(1) instead. filter-branch also allows reformatting of metadata for ease-of-reading and rewriting authorship info for non-"svn.authorsFile" users.
```

## The Cleanup

After the migration, you should also do some post-import cleanup.
For one thing, you should clean up the weird references that git svn set up. First, you’ll move the tags so they’re actual tags rather than strange remote branches, and then you’ll move the rest of the branches so they’re local.

To move the tags to be proper Git tags, run:

```sh
for t in $(git for-each-ref --format='%(refname:short)' refs/remotes/tags); do git tag ${t/tags\//} $t && git branch -D -r $t; done
```

This takes the references that were remote branches that started with `refs/remotes/tags/` and makes them real (lightweight) tags.

Next, move the rest of the references under `refs/remotes` to be local branches:

```sh
$ for b in $(git for-each-ref --format='%(refname:short)' refs/remotes); do git branch $b refs/remotes/$b && git branch -D -r $b; done
```

It may happen that you’ll see some extra branches which are suffixed by @NNN (where NNN is a number), while in Subversion you only see one branch.
This is a Subversion feature called `peg-revisions`, which is something that Git simply has no syntactical counterpart for.
Hence, `git-svn` simply adds the svn version number to the branch name just in the same way as you would have written it in svn to address the peg-revision of that branch.
If you do not care anymore about the peg-revisions, simply remove them:

```sh
for p in $(git for-each-ref --format='%(refname:short)' | grep @); do git branch -D $p; done
```

Now all the old branches are real Git branches and all the old tags are real Git tags.

There’s one last thing to clean up. Unfortunately, `git-svn` creates an extra branch named trunk, which maps to Subversion’s default branch, but the trunk ref points to the same place as master. Since master is more idiomatically Git, here’s how to remove the extra branch:

```sh
git branch -d trunk
```

The last thing to do is add your new Git server as a remote and push to it. Here is an example of adding your server as a remote:

```sh
git remote add origin git@my-git-server:myrepository.git
```

Because you want all your branches and tags to go up, you can now run this:

$ git push origin --all

## Further Reading

- https://objectpartners.com/2014/02/04/getting-started-with-git-svn/
- https://git-scm.com/book/en/v2/Git-and-Other-Systems-Migrating-to-Git
