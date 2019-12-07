---
toc: true
---

# Brands and Models

## Dell PowerEdge Servers

### Generation 10 + ( After 2007)

Models consist of a letter(s) followed by three or four numbers. For example: **PowerEdge R710** or **PowerEdge R6415**.

#### Three numbers models.

<span class="label">type</span><span class="label blue-bg">#1</span><span class="label green-bg">#2</span><span class="label red-bg">#3</span>

<span class="label">type</span>

- **R** = Rack-mountable servers
- **T** = Tower Servers
- **C** = Cloud - Modular server nodes for hyper-scale environments
- **F** = Flexible - Hybrid rack-based sleds for rack-based FX2/FX2s enclosure
- **M** or **[MX](#modular-models)** = Modular - Blade servers and other items for the modular enclosure MX7000, M1000e and/or VRTX

<span class="label blue-bg">#1</span> Class of the system. With 1-3 being 1 CPU systems, 4 - 7 are 2 CPU systems, 8 can be 2 or 4 CPUs and 9 is 4 CPUs. |

<span class="label green-bg">#2</span> The generation, with 0 for 10th generation, 1 for 11th generation and so on.

<span class="label red-bg">#3</span> Make of the CPU, 0 for Intel and 5 for AMD.

#### Four numbers models.

<span class="label">type</span><span class="label grey-bg">#1</span><span class="label blue-bg">#2</span><span class="label green-bg">#3</span><span class="label red-bg">#4</span>

<span class="label grey-bg">#1</span> Class of the system. With 1-5 defaulting to iDRAC Basic and 6 - 9 defaulting to iDRAC Express.  

<span class="label blue-bg">#2</span> Generation, with 0 for 10th generation, 1 for 11th generation and so on.  

<span class="label green-bg">#3</span> Number of CPUs, 1 for 1 CPU and 2 for 2 CPUs.  

<span class="label red-bg">#4</span>  Make of the CPU, 0 for Intel and 5 for AMD.

### Generation 10 - ( Before 2007)

Models used 4 digits. For example: **PowerEdge 1900**

<span class="label">#1</span><span class="label blue-bg">#2</span><span class="label green-bg">#3</span><span class="label red-bg">#4</span>

<span class="label">#1</span>Rack Units.

<span class="label blue-bg">#2</span>Generation of server (up to 9th generation).

<span class="label green-bg">#3</span>Server type (5 for rack server, 0 for tower server).

<span class="label red-bg">#4</span>Indicated whether blade or independent box (5 for blade, 0 for normal independent box).

### Modular Models

The `PowerEdge MX7000` was introduced during the **14th Generation** range and are identified with an additional letter appended to the end of the model name.

- **c** = For Compute
- **s** = For Storage
- **n** = For IO

The `PowerEdge M1000e` was introduced during the 10th Generation range. The supported server module types are designated as Mxxx.

The `PowerEdge VRTX` was introduced during the 12th Generation range. The supported server module types are designated as Mxxx (for PE VRTX).

The `PowerEdge FX2/FX2s` was introduced during the 13th Generation range. The supported compute sleds are designated as FCxxx and FMxxx. The supported storage sleds are designated as FDxxx.

### Itanium servers

The Itanium line was a separate generation from the traditional server line, but roughly falls **between generations 5 and 6**. 
These servers were introduced before this new naming-convention and were only available as rack servers.

### Examples

- **PowerEdge R710** = Rack 2 CPU system from the 11th generation with Intel Processors.
- **PowerEdge R6415** = Rack 1 CPU system from the 14th generation of servers with AMD Processors.
- **PowerEdge 1900** = 1 Unit Tower from the 9th generation with Intel Processors.
- **PowerEdge 6950** = 4 Units Rack from the 9th generation with AMD Processors.

### Links

- [List of Dell PowerEdge Servers](https://en.wikipedia.org/wiki/List_of_Dell_PowerEdge_Servers) on Wikipedia. 
- [Official Dell PowerEdge Manuals](https://dell.com/Poweredgemanuals).

# Server Types

## Tower servers

This type of server is similar to a desktop computer.  
The advantages of a tower server lie not only in the fact that it is relatively compact but also in its ability to be used in work areas which are not specifically designed to accommodate servers, meaning that you do not need a special data room or any special bays in which to install the server.

## Rack servers

A rack server is designed to be positioned in a bay, which enables you to stack various devices on top of each other in a large tower. The bay will accommodate all of the hardware devices the company needs to function, including the server, storage devices, and security and network appliances.  
The benefit of this type of server is that having all components of the system located in the same place makes it easier to manage connections and maintain the system.

## Blade servers

Slim and compact, just like a blade, they slide vertically into a specially designed chassis. They also share certain elements of the hardware with other blade servers in the chassis for efficiency and cost reduction. Blade servers, for example, use a single feed positioned on the host compartment.  
In short, blade servers will give you much greater processing power, take up less space and use less energy than other forms of server used for the same purposes.

# Rack Cabinets

## Rack Types

There are many things to consider when buying a cabinet, *spend time on planning*. Think about how many units you need and how many units you *will need*, where are you going to place it, the space available, if the place is ventilated, if it's hot or dusty, if it's isolated (remember it gets pretty noisy) and if you need to mount it on a wall.
For both regular or wall-mounted racks, there's closed and open cabinets. Also, for regular cabinets you can have open 2-post structures.
A close cabinet gives security but you have to be careful with ventilation. While open cabinets are cheaper and provide good airflow, noise and sound are a factor to consider.

## Rack Units

Rack units are used to measure the height of rack-mounted equipment and is defined as 1 3⁄4 inches (1.75 inches or 44.45 mm).
Racks, like other electronics designed to fit on them, are standardized. They come in two widths: 19-inch (482.6 mm) and 23-inch (584.2 mm) but the 19-inch racks are the most commonly used today.

[![xkcd: Rack Unit](/assets/images/posts/xkcd_rack_unit.png)](https://xkcd.com/1439/)

## Height

Generally, you want to keep in mind both what the cabinet's external height is, and how many "U's" (rack units) of rack-mountable equipment you need to fit in it.  
External height is important, allow enough room for ceiling clearance for ventilation and cable management.
The internal height is measured in units. Count the units of your equipment, keeping in mind the room you need for a KVM switch, UPS, patch panel, etc, and give yourself at least 10% additional room for expansion.
If you want to put in equipment that isn't rack-mountable, you should measure the size and divide the height by 1.75 if measured in inches, or 44.45 if measured in mm, to give you an approximate size in 'u', this equipment will need to be on a shelf which will take an additional 1u of space.

## Width

For 19-inch racks, we usually have two configurations, 23.6 inches (600mm) and 31.5 inches (800mm). The main difference between them is the room for cable management. If you are using your server cabinet for patching as well, I would recommend a 31.5 inches wide rack as this will have a lot more space for cable management.

## Depth

Depth is also pretty important since manufacturers are making server a lot deeper. Consider you need more depth than the server's depth, for example for an 800mm server you need a 1000mm depth rack.
For servers, you will need more than 32 inches. You can get a middle depth rack of 31 inches, a regular depth of 37 inches and for cable management and better airflow, you can get a 42 inches depth. Ideally, go with the latter but the 37 will also do its job.
