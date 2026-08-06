package
{
   import com.sulake.bootstrap.SessionDataManagerBootstrap;
   import com.sulake.iid.IIDSessionDataManager;
   import mx.core.SimpleApplication;
   
   [SecureSWF(rename="false")]
   public class HabboSessionDataManagerLib extends SimpleApplication
   {
      public static var requiredClasses:Array = new Array(SessionDataManagerBootstrap,IIDSessionDataManager);
      
      public static var manifest:Class = manifest_6_xml;
      
      public static var loading_icon:Class = loading_icon_2_png;
      
      public function HabboSessionDataManagerLib()
      {
         super();
      }
   }
}

