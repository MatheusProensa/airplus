package
{
   import com.sulake.bootstrap.HabboConfigurationManagerBootstrap;
   import com.sulake.habbo.configuration.HabboConfigurationManager;
   import com.sulake.iid.IIDHabboConfigurationManager;
   import mx.core.SimpleApplication;
   
   [SecureSWF(rename="false")]
   public class HabboConfigurationCom extends SimpleApplication
   {
      public static var requiredClasses:Array = new Array(HabboConfigurationManagerBootstrap,IIDHabboConfigurationManager,HabboConfigurationManager);
      
      public static var manifest:Class = manifest_2_xml;
      
      public static var common_configuration:Class = common_configuration_1_txt;
      
      public static var localization_configuration:Class = localization_configuration_1_txt;
      
      public function HabboConfigurationCom()
      {
         super();
      }
   }
}

