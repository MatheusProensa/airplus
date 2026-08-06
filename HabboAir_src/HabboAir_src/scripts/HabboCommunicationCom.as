package
{
   import com.sulake.bootstrap.HabboCommunicationManagerBootstrap;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import mx.core.SimpleApplication;
   
   [SecureSWF(rename="false")]
   public class HabboCommunicationCom extends SimpleApplication
   {
      public static var requiredClasses:Array = new Array(HabboCommunicationManagerBootstrap,IIDHabboCommunicationManager);
      
      public static var manifest:Class = manifest_36_xml;
      
      public function HabboCommunicationCom()
      {
         super();
      }
   }
}

