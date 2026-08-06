package
{
   import com.sulake.bootstrap.HabboTrackingBootstrap;
   import com.sulake.iid.IIDHabboTracking;
   import mx.core.SimpleApplication;
   
   [SecureSWF(rename="false")]
   public class HabboTrackingLib extends SimpleApplication
   {
      public static var manifest:Class = manifest_8_xml;
      
      public static var requiredClasses:Array = new Array(HabboTrackingBootstrap,IIDHabboTracking);
      
      public function HabboTrackingLib()
      {
         super();
      }
   }
}

