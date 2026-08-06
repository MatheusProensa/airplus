package
{
   import com.sulake.bootstrap.RoomRendererFactoryBootstrap;
   import com.sulake.iid.IIDRoomRendererFactory;
   import mx.core.SimpleApplication;
   
   [SecureSWF(rename="false")]
   public class RoomSpriteRendererLib extends SimpleApplication
   {
      public static var manifest:Class = manifest_20_xml;
      
      public static var requiredClasses:Array = new Array(RoomRendererFactoryBootstrap,IIDRoomRendererFactory);
      
      public function RoomSpriteRendererLib()
      {
         super();
      }
   }
}

