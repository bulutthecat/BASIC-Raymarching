# BASIC-Raymarching
A MS-DOS 16 bit rendering engine written in QBASIC

This program has been fully written by me, as a challange to learn basic in two weeks. As this progressed, I have continued adding new features and functionality to the program to make it a fully fledged MSDOS engine.
Currenty it only supports rendering triangles in wireframe, though I have experamented with adding full raymarching and color support which is coming soon.

# Usage

* It is recomended to use the rewrite branch, as it has the latest tested updates

You can start the program by running the command:

```
C:\RAYMARCH.EXE
```

Running the raymarching executable initially without any command line flags will load ten cubes placed randomly within a 10x10x10 area.
The default camera movement controlls work as follows:

```
W > move camera forward
S > move camera back
A > move camera right
D > move camera left
```

* It is important to note that these are sticky controls, meaning it will continue moving in the direction you inputted until a reset movement key is pressed, where velocity is reset and the camera stays at its current position.

The reset key is: 
```
R > reset camera velocity
```

The same velocity/sticky principals work in camera rotation as well, the camera rotation works with the arrow keys:
```
↑ > pan camera up
↓ > pan camera down
→ > pan camera right
← > pan camera left
```
The same reset key applies.

# Command line arguments

A couple default command line arguments exist to help in usage. which are listed below:
```
C:\RAYMARCH.EXE /F FILENAME.CSV | load CSV file for rendering
C:\RAYMARCH.EXE /S              | load from serial server modem
C:\RAYMARCH.EXE /H              | host serial server for clients
```

# Blender integration

When using the blender plugin supplied with the program, you can build a scene which includes cubes and export it as a CSV document. The CSV document will contain the information of the scene, which can be loaded using the aformeantioned ```/F``` command line argument.

You can export by following the below steps:
```
File > export > CUBES
```
Then select a folder and filename. The filename dosnt have to have a .CSV extension, but it is reccomended for ease of use.

* The blender plugin currently dosnt support custom meshes, you can only use cubes.

# File/build locations

All builds can be found in the /RAYMARCH/BUILD/ directory
If you want to build from scratch, a QB16 DOS compiler is supplied. QuickBasic Pheonix 64 is supported for native MacOS, Linux/UNIX, Windows Vista > Windows 11 compilation; Though this will require minor modifications to source to point to dependencies as MAK compiles are not supported for modern systems.

Builds using QuickBasic 64 Pheonix will be included in the next major update, as a dedicated modern operating systems branch.

When loading the file in QB16, load the ```RAYMARCH.BAS``` file, the QB compiler should read the MAK and locate the required dependencies. DOSBOX-X is currently the only stable reccomended compile environment. From there, ```RUN > BUILD EXE```. DO NOT USE STANDALONE BUILD.
