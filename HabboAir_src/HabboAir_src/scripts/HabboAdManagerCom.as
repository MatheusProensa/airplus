package
{
   import com.sulake.bootstrap.AdManagerBootstrap;
   import com.sulake.iid.IIDHabboAdManager;
   import mx.core.SimpleApplication;
   
   [SecureSWF(rename="false")]
   public class HabboAdManagerCom extends SimpleApplication
   {
      public static var manifest:Class = manifest_23_xml;
      
      public static var requiredClasses:Array = new Array(AdManagerBootstrap,IIDHabboAdManager);
      
      public function HabboAdManagerCom()
      {
         super();
      }
   }
}

