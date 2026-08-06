package
{
   import com.sulake.bootstrap.HabboDiscordManagerBootstrap;
   import com.sulake.iid.IIDHabboDiscordManager;
   import mx.core.SimpleApplication;
   
   [SecureSWF(rename="false")]
   public class HabboDiscordCom extends SimpleApplication
   {
      public static var discord_settings_xml:Class = discord_settings_1_xml;
      
      public static var manifest:Class = manifest_34_xml;
      
      public static var requiredClasses:Array = new Array(HabboDiscordManagerBootstrap,IIDHabboDiscordManager);
      
      public function HabboDiscordCom()
      {
         super();
      }
   }
}

