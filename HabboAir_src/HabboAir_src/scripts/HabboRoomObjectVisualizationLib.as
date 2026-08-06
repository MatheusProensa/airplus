package
{
   import com.sulake.bootstrap.RoomObjectVisualizationFactoryBootstrap;
   import com.sulake.iid.IIDRoomObjectVisualizationFactory;
   import mx.core.SimpleApplication;
   
   [SecureSWF(rename="false")]
   public class HabboRoomObjectVisualizationLib extends SimpleApplication
   {
      public static var manifest:Class = manifest_11_xml;
      
      public static var pet_experience_bubble_png:Class = pet_experience_bubble_1_png;
      
      public static var snowball_small_png:Class = snowball_small_1_png;
      
      public static var snowball_small_shadow_png:Class = snowball_small_shadow_1_png;
      
      public static var snowball_big_png:Class = snowball_big_1_png;
      
      public static var snowball_splash_1:Class = snowball_splash_1_1_png;
      
      public static var snowball_splash_2:Class = snowball_splash_2_1_png;
      
      public static var snowball_splash_3:Class = snowball_splash_3_1_png;
      
      public static var requiredClasses:Array = new Array(RoomObjectVisualizationFactoryBootstrap,IIDRoomObjectVisualizationFactory);
      
      public function HabboRoomObjectVisualizationLib()
      {
         super();
      }
   }
}

