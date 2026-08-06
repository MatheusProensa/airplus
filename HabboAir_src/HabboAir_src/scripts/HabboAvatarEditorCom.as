package
{
   import com.sulake.bootstrap.HabboAvatarEditorManagerBootstrap;
   import com.sulake.iid.IIDHabboAvatarEditor;
   import mx.core.SimpleApplication;
   
   [SecureSWF(rename="false")]
   public class HabboAvatarEditorCom extends SimpleApplication
   {
      public static var requiredClasses:Array = new Array(HabboAvatarEditorManagerBootstrap,IIDHabboAvatarEditor);
      
      public static var manifest:Class = manifest_35_xml;
      
      public static var AvatarEditor:Class = AvatarEditor_1_xml;
      
      public static var AvatarEditorFrame:Class = AvatarEditorFrame_1_xml;
      
      public static var AvatarEditorContent:Class = AvatarEditorContent_1_xml;
      
      public static var StripClubItemsInfo:Class = StripClubItemsInfo_1_xml;
      
      public static var Outfit:Class = Outfit_1_xml;
      
      public static var avatareditor_wardrobe_base:Class = avatareditor_wardrobe_base_1_xml;
      
      public static var avatar_editor_effect_griditem_xml:Class = avatar_editor_effect_griditem_1_xml;
      
      public static var avatar_editor_name_change:Class = avatar_editor_name_change_1_xml;
      
      public static var avatar_editor_name_change_item:Class = avatar_editor_name_change_item_1_xml;
      
      public function HabboAvatarEditorCom()
      {
         super();
      }
   }
}

