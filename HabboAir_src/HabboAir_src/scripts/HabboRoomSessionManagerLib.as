package
{
   import com.sulake.bootstrap.RoomSessionManagerBootstrap;
   import com.sulake.iid.IIDHabboRoomSessionManager;
   import mx.core.SimpleApplication;
   
   [SecureSWF(rename="false")]
   public class HabboRoomSessionManagerLib extends SimpleApplication
   {
      public static var manifest:Class = manifest_9_xml;
      
      public static var requiredClasses:Array = new Array(RoomSessionManagerBootstrap,IIDHabboRoomSessionManager);
      
      public function HabboRoomSessionManagerLib()
      {
         super();
      }
   }
}

