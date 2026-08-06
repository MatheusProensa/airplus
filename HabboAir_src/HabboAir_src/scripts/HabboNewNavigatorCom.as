package
{
   import com.sulake.bootstrap.HabboNewNavigatorBootstrap;
   import com.sulake.iid.IIDHabboNewNavigator;
   import mx.core.SimpleApplication;
   
   [SecureSWF(rename="false")]
   public class HabboNewNavigatorCom extends SimpleApplication
   {
      public static var manifest:Class = manifest_26_xml;
      
      public static var navigator_frame_2_xml:Class = navigator_frame_2_1_xml;
      
      public static var room_info_popup_bubble_xml:Class = room_info_popup_bubble_1_xml;
      
      public static var property_xml:Class = property_1_xml;
      
      public static var tag_xml:Class = tag_1_xml;
      
      public static var requiredClasses:Array = new Array(HabboNewNavigatorBootstrap,IIDHabboNewNavigator);
      
      public function HabboNewNavigatorCom()
      {
         super();
      }
   }
}

