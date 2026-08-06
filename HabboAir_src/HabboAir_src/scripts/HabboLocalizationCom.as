package
{
   import com.sulake.bootstrap.HabboLocalizationManagerBootstrap;
   import com.sulake.core.localization.ICoreLocalizationManager;
   import com.sulake.habbo.localization.HabboLocalizationManager;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.iid.IIDCoreLocalizationManager;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import mx.core.SimpleApplication;
   
   [SecureSWF(rename="false")]
   public class HabboLocalizationCom extends SimpleApplication
   {
      public static var requiredClasses:Array = new Array(HabboLocalizationManagerBootstrap,IIDCoreLocalizationManager,IIDHabboLocalizationManager,ICoreLocalizationManager,IHabboLocalizationManager,HabboLocalizationManager);
      
      public static var manifest:Class = manifest_24_xml;
      
      public static var default_localizations:Class = default_localizations_1_txt;
      
      public static var default_localizations_pt:Class = default_localizations_pt_1_txt;
      
      public static var default_localizations_de:Class = default_localizations_de_1_txt;
      
      public static var default_localizations_tr:Class = default_localizations_tr_1_txt;
      
      public static var default_localizations_dk:Class = default_localizations_dk_1_txt;
      
      public static var default_localizations_es:Class = default_localizations_es_1_txt;
      
      public static var default_localizations_fi:Class = default_localizations_fi_1_txt;
      
      public static var default_localizations_fr:Class = default_localizations_fr_1_txt;
      
      public static var default_localizations_it:Class = default_localizations_it_1_txt;
      
      public static var default_localizations_nl:Class = default_localizations_nl_1_txt;
      
      public static var default_localizations_no:Class = default_localizations_no_1_txt;
      
      public static var default_localizations_se:Class = default_localizations_se_1_txt;
      
      public static var default_localizations_en:Class = default_localizations_en_1_txt;
      
      public function HabboLocalizationCom()
      {
         super();
      }
   }
}

