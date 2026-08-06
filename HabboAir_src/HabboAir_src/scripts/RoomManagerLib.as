package
{
   import com.sulake.bootstrap.RoomManagerBootstrap;
   import com.sulake.iid.IIDRoomManager;
   import mx.core.SimpleApplication;
   
   [SecureSWF(rename="false")]
   public class RoomManagerLib extends SimpleApplication
   {
      public static var manifest:Class = manifest_19_xml;
      
      public static var requiredClasses:Array = new Array(RoomManagerBootstrap,IIDRoomManager);
      
      public function RoomManagerLib()
      {
         super();
      }
   }
}

