package
{
   import com.sulake.bootstrap.HabboCommunicationDemoBootstrap;
   import mx.core.SimpleApplication;
   
   [SecureSWF(rename="false")]
   public class HabboCommunicationDemoCom extends SimpleApplication
   {
      public static var manifest:Class = manifest_30_xml;
      
      public static var login_window:Class = login_window_1_xml;
      
      public static var error_popup:Class = error_popup_1_xml;
      
      public static var login_environment_list_item:Class = login_environment_list_item_1_xml;
      
      public static var requiredClasses:Array = new Array(HabboCommunicationDemoBootstrap);
      
      public function HabboCommunicationDemoCom()
      {
         super();
      }
   }
}

