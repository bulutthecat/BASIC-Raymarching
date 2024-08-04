import bpy
import csv
import os

class ExportCubesOperator(bpy.types.Operator):
    """Operator to export cube data to a CSV file"""
    bl_idname = "export.cubes"
    bl_label = "Export Cubes"
    bl_options = {'REGISTER', 'UNDO'}
    
    filepath: bpy.props.StringProperty(subtype="FILE_PATH")

    def execute(self, context):
        if not self.filepath:
            context.window_manager.fileselect_add(self)
            return {'RUNNING_MODAL'}
        else:
            self.export_cubes(self.filepath)
            self.report({'INFO'}, "Cubes exported successfully")
            return {'FINISHED'}

    def export_cubes(self, filepath):
        """Exports all cubes in the scene to a CSV file"""
        os.makedirs(os.path.dirname(filepath), exist_ok=True)
        
        with open(filepath, 'w', newline='') as file:
            writer = csv.writer(file)
            writer.writerow(["x", "y", "z", "rot_x", "rot_y", "rot_z", "height", "length", "width"])
            for obj in bpy.context.scene.objects:
                if obj.type == 'MESH' and obj.name.startswith("Cube"):
                    location = obj.location
                    rotation = obj.rotation_euler
                    scale = obj.scale
                    writer.writerow([location.x, location.y, location.z, 
                                     rotation.x, rotation.y, rotation.z,
                                     scale.x, scale.y, scale.z])

    def invoke(self, context, event):
        if not self.filepath:
            context.window_manager.fileselect_add(self)
            return {'RUNNING_MODAL'}
        return self.execute(context)

class ExportCubesPanel(bpy.types.Panel):
    """Panel for exporting cubes to CSV"""
    bl_label = "Export Cubes Panel"
    bl_idname = "VIEW3D_PT_export_cubes"
    bl_space_type = 'VIEW_3D'
    bl_region_type = 'UI'
    bl_category = 'Export Cubes'

    def draw(self, context):
        layout = self.layout
        layout.operator("export.cubes", text="Export Cubes")

def menu_func(self, context):
    self.layout.operator(ExportCubesOperator.bl_idname, text="Export Cubes")

def register():
    bpy.utils.register_class(ExportCubesOperator)
    bpy.utils.register_class(ExportCubesPanel)
    bpy.types.TOPBAR_MT_file_export.append(menu_func)

def unregister():
    bpy.utils.unregister_class(ExportCubesOperator)
    bpy.utils.unregister_class(ExportCubesPanel)
    bpy.types.TOPBAR_MT_file_export.remove(menu_func)

if __name__ == "__main__":
    register()
