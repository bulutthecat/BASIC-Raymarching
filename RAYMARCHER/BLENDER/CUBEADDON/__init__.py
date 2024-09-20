import bpy
from . import main

bl_info = {
    "name": "CSV Cube Exporter",
    "blender": (3, 0, 0),
    "category": "Object",
    "version": (1, 0, 0),
    "author": "Kevin Dalli",
    "description": "Exports cube objects as CSV.",
}

def register():
    main.register()

def unregister():
    main.unregister()

if __name__ == "__main__":
    register()
