package onBoardingHcUi
{
   import com.sulake.core.localization.ICoreLocalizationManager;
   import com.sulake.core.localization.ILocalizable;
   import flash.text.TextField;
   
   public class LocalizedTextField extends TextField implements ILocalizable
   {
      private static var _localizationManager:ICoreLocalizationManager;
      
      protected var _localized:Boolean = false;
      
      private var _key:String;
      
      public function LocalizedTextField()
      {
         super();
      }
      
      public static function set localizationManager(param1:ICoreLocalizationManager) : void
      {
         _localizationManager = param1;
      }
      
      public static function get localizationManager() : ICoreLocalizationManager
      {
         return _localizationManager;
      }
      
      public function dispose() : void
      {
         removeOldLocalization(_key);
      }
      
      override public function set htmlText(param1:String) : void
      {
         super.htmlText = param1;
         checkLocalization(param1);
         if(_localized)
         {
         }
      }
      
      public function set localization(param1:String) : void
      {
         super.htmlText = param1;
      }
      
      protected function removeOldLocalization(param1:String) : void
      {
         if(_localized)
         {
            localizationManager.removeListener(param1.slice(2,param1.indexOf("}")),this);
            _localized = false;
         }
      }
      
      protected function checkLocalization(param1:String) : void
      {
         if(localizationManager && param1 && param1.charAt(0) == "$" && param1.charAt(1) == "{")
         {
            removeOldLocalization(_key);
            _key = param1;
            _localized = true;
            localizationManager.registerListener(param1.slice(2,param1.indexOf("}")),this);
         }
      }
   }
}

