package
{
   import com.sulake.bootstrap.RoomEngineBootstrap;
   import com.sulake.iid.IIDRoomEngine;
   import mx.core.SimpleApplication;
   
   [SecureSWF(rename="false")]
   public class HabboRoomEngineCom extends SimpleApplication
   {
      public static var manifest:Class = manifest_25_xml;
      
      public static var requiredClasses:Array = new Array(RoomEngineBootstrap,IIDRoomEngine);
      
      public function HabboRoomEngineCom()
      {
         super();
      }
   }
}

