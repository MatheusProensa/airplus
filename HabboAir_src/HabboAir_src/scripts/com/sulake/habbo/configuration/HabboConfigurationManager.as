package com.sulake.habbo.configuration
{
   import com.sulake.core.Core;
   import com.sulake.core.assets.AssetLibrary;
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.assets.TextAsset;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.IComponent_1;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.core.runtime.ICoreComponentContext;
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.utils.CommunicationUtils;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.system.Security;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class HabboConfigurationManager extends Component implements IComponent_1, IHabboConfigurationManager
   {
      private static const INTERPOLATION_DEPTH_LIMIT:int = 3;
      
      private static const REPLACE_CHAR:String = "%";
      
      private static const HABBICONS_RESOURCE_NAME:String = "habbicons";
      
      private static const UnknownConstFromHabboConfigurationManager_String_1:String = "habbicons.asset.root";
      
      private static const HABBICONS_ASSET_HASH:String = "habbicons.asset.hash";
      
      private static const UnknownConstFromHabboConfigurationManager_String_2:String = "habbicons.url";
      
      private static const HABBICONS_EXTERNAL_HASH:String = "habbicons.hash";
      
      private static const UnknownConstFromHabboConfigurationManager_String_3:String = "https://images.habbo.com/habbicons";
      
      private var UnknownVarFromHabboConfigurationManager_Boolean_1:Boolean = false;
      
      private var UnknownVarFromHabboConfigurationManager_Boolean_2:Boolean = false;
      
      private var UnknownVarFromHabboConfigurationManager_Dictionary_1:Dictionary;
      
      private var _isInitialized:Boolean = false;
      
      private var _readOnlyProperties:Array = [];
      
      private var UnknownVarFromHabboConfigurationManager_Boolean_3:Boolean = false;
      
      private var UnknownVarFromHabboConfigurationManager_String_1:String;
      
      private var _localization:IHabboLocalizationManager;
      
      public function HabboConfigurationManager(param1:IComponent_2, param2:uint = 0, param3:IAssetLibraryCollection = null)
      {
         super(param1,param2,param3);
         param1.configuration = this;
         UnknownVarFromHabboConfigurationManager_Boolean_1 = (param2 & 268435456) > 0;
         UnknownVarFromHabboConfigurationManager_Boolean_2 = (param2 & 16777216) > 0;
         lock();
         resetAll();
         if(!propertyExists("environment.id") && CommunicationUtils.propertyExists("environment"))
         {
            updateEnvironmentId(CommunicationUtils.readSOLString("environment"));
         }
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localization = param1;
         },false,[{
            "type":"complete",
            "callback":onLocalizationComplete
         }])]);
      }
      
      private function onLocalizationComplete(param1:Event) : void
      {
         initConfigurationDownload();
      }
      
      public function updateEnvironmentId(param1:String) : void
      {
         if(UnknownVarFromHabboConfigurationManager_String_1 != param1)
         {
            UnknownVarFromHabboConfigurationManager_String_1 = param1;
            setProperty("environment.id",param1);
            AssetLibrary.setCacheNamespace(param1);
            updateEnvironmentVariables();
         }
         initEmbeddedConfigurations();
         setDefaults();
      }
      
      public function resetAll() : void
      {
         _isInitialized = false;
         UnknownVarFromHabboConfigurationManager_Dictionary_1 = new Dictionary();
         _readOnlyProperties = [];
         parseDevelopmentVariables();
         parseCommonVariables();
         parseLocalizationVariables();
         setProperty("flash.client.url","app:/");
         parseArguments();
         setDefaults();
         updateEnvironmentVariables();
         if(!propertyExists("environment.id"))
         {
            initEmbeddedConfigurations();
         }
         if(!_isInitialized && UnknownVarFromHabboConfigurationManager_Boolean_1)
         {
            _isInitialized = true;
            unlock();
            events.dispatchEvent(new Event("complete"));
         }
         else if(!_isInitialized && UnknownVarFromHabboConfigurationManager_Boolean_2)
         {
            initConfigurationDownload();
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      public function isInitialized() : Boolean
      {
         return _isInitialized;
      }
      
      private function updateEnvironmentVariables() : void
      {
         var _loc1_:String = null;
         var _loc5_:String = null;
         var _loc3_:String = null;
         var _loc4_:Vector.<String> = new Vector.<String>(0);
         _loc4_.push("connection.info.host");
         _loc4_.push("connection.info.port");
         _loc4_.push("url.prefix");
         _loc4_.push("site.url");
         _loc4_.push("flash.dynamic.download.url");
         _loc4_.push("flash.dynamic.download.name.template");
         _loc4_.push("flash.dynamic.avatar.download.configuration");
         _loc4_.push("flash.dynamic.avatar.download.url");
         _loc4_.push("pocket.api");
         _loc4_.push("web.api");
         _loc4_.push("facebook.application.id");
         _loc4_.push("web.terms_of_service.link");
         for each(var _loc2_ in _loc4_)
         {
            _loc1_ = getProperty(_loc2_);
            _loc5_ = _loc2_ + "." + UnknownVarFromHabboConfigurationManager_String_1;
            if(propertyExists(_loc5_))
            {
               _loc3_ = getProperty(_loc5_);
               setProperty(_loc2_,_loc3_);
            }
            else
            {
               setProperty(_loc2_,_loc1_);
            }
         }
      }
      
      override public function propertyExists(param1:String) : Boolean
      {
         var _loc2_:String = UnknownVarFromHabboConfigurationManager_Dictionary_1[param1] as String;
         return _loc2_ != null;
      }
      
      override public function getProperty(param1:String, param2:Dictionary = null) : String
      {
         var _loc3_:String = UnknownVarFromHabboConfigurationManager_Dictionary_1[param1] as String;
         _loc3_ = interpolate(_loc3_);
         if(_loc3_ == null)
         {
            return "";
         }
         if(_loc3_.substr(0,2) == "//")
         {
            _loc3_ = (UnknownVarFromHabboConfigurationManager_Boolean_3 ? "https:" : "http:") + _loc3_;
         }
         _loc3_ = updateUrlProtocol(_loc3_);
         if(param2 != null)
         {
            _loc3_ = this.fillParams(_loc3_,param2);
         }
         return _loc3_.replace("http://","https://");
      }
      
      override public function setProperty(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false) : void
      {
         if(param4)
         {
            if(UnknownVarFromHabboConfigurationManager_Dictionary_1[param1] == null)
            {
               Logger.log(param1 + "=" + param2);
            }
         }
         if(param1 == "environment.id")
         {
            UnknownVarFromHabboConfigurationManager_String_1 = param2;
            AssetLibrary.setCacheNamespace(param2);
         }
         if(_readOnlyProperties.indexOf(param1) < 0 || param3)
         {
            UnknownVarFromHabboConfigurationManager_Dictionary_1[param1] = param2;
         }
         if(param3)
         {
            _readOnlyProperties.push(param1);
         }
      }
      
      override public function getBoolean(param1:String) : Boolean
      {
         var _loc2_:String = UnknownVarFromHabboConfigurationManager_Dictionary_1[param1] as String;
         if(_loc2_ == null)
         {
            return false;
         }
         return _loc2_ == "1" || _loc2_.toLowerCase() == "true";
      }
      
      override public function getInteger(param1:String, param2:int) : int
      {
         var _loc3_:String = UnknownVarFromHabboConfigurationManager_Dictionary_1[param1] as String;
         if(_loc3_ == null)
         {
            return param2;
         }
         return int(_loc3_);
      }
      
      override public function updateUrlProtocol(param1:String) : String
      {
         var _loc2_:* = param1;
         if(UnknownVarFromHabboConfigurationManager_Boolean_3)
         {
            _loc2_ = param1.replace("http://","https://");
            _loc2_ = _loc2_.replace(":8090/",":8443/");
         }
         return _loc2_;
      }
      
      override public function interpolate(param1:String) : String
      {
         var _loc6_:int = 0;
         var _loc5_:Object = null;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         if(param1 == null)
         {
            return null;
         }
         var _loc4_:* = param1;
         var _loc7_:RegExp = /\${([^}]*)}/g;
         _loc6_ = 0;
         while(_loc6_ < 3)
         {
            _loc2_ = 0;
            _loc3_ = "";
            while(true)
            {
               _loc5_ = _loc7_.exec(_loc4_);
               if(_loc5_ == null)
               {
                  break;
               }
               if(!propertyExists(_loc5_[1]))
               {
                  return null;
               }
               _loc3_ += _loc4_.substring(_loc2_,_loc5_.index);
               _loc3_ += getProperty(_loc5_[1]);
               _loc2_ = _loc5_.index + _loc5_[0].length;
            }
            _loc3_ += _loc4_.substring(_loc2_);
            if(_loc3_ == _loc4_)
            {
               break;
            }
            _loc4_ = _loc3_;
            _loc6_++;
         }
         return _loc3_;
      }
      
      public function initConfigurationDownload() : void
      {
         var _loc2_:AssetLoaderStruct = null;
         var _loc1_:URLRequest = null;
         var _loc4_:String = null;
         _isInitialized = false;
         var _loc3_:String = _localization == null ? getProperty("external.variables.txt") : "variables_" + _localization.getActiveEnvironmentId().toLowerCase() + "_" + _localization.getExternalVariablesHash();
         if(assets.hasAsset(_loc3_))
         {
            assets.removeAsset(assets.getAssetByName(_loc3_));
         }
         if(_localization == null)
         {
            _loc1_ = new URLRequest(_loc3_);
            _loc2_ = assets.loadAssetFromFile(_loc3_,_loc1_,"text/plain");
            _loc2_.addEventListener("AssetLoaderEventComplete",onInitConfiguration);
            _loc2_.addEventListener("AssetLoaderEventError",onConfigurationError);
         }
         else
         {
            _loc4_ = _localization.getExternalVariablesUrl() + "/" + _localization.getExternalVariablesHash();
            _loc2_ = assets.loadAssetFromFile(_loc3_,new URLRequest(_loc4_),"text/plain");
            _loc2_.addEventListener("AssetLoaderEventComplete",onInitConfiguration);
            _loc2_.addEventListener("AssetLoaderEventError",onConfigurationError);
         }
      }
      
      private function parseConfiguration(param1:String) : void
      {
         var _loc8_:Array = null;
         var _loc9_:String = null;
         var _loc7_:String = null;
         var _loc2_:RegExp = /\n\r{1,}|\n{1,}|\r{1,}/gm;
         var _loc6_:RegExp = /^\s+|\s+$/g;
         var _loc5_:Array = param1.split(_loc2_);
         var _loc4_:Boolean = false;
         for each(var _loc3_ in _loc5_)
         {
            if(!(_loc3_.substr(0,1) == "#" || _loc3_ == ""))
            {
               _loc8_ = _loc3_.split("=");
               if(_loc8_.length >= 2 && _loc8_[0].length > 0 && _loc8_[1].length > 0)
               {
                  _loc9_ = _loc8_.shift();
                  _loc7_ = _loc8_.join("=");
                  _loc9_ = _loc9_.replace(_loc6_,"");
                  _loc7_ = _loc7_.replace(_loc6_,"");
                  if(_loc9_ == "configuration.readonly" && _loc7_ == "true")
                  {
                     _loc4_ = true;
                  }
                  this.setProperty(_loc9_,_loc7_,_loc4_);
               }
            }
         }
      }
      
      private function initEmbeddedConfigurations() : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc1_:String = CommunicationUtils.readSOLString("environment");
         Logger.log("[HabboConfigurationManager] Default Environment: " + _loc1_);
         for(var _loc5_ in UnknownVarFromHabboConfigurationManager_Dictionary_1)
         {
            _loc2_ = int(_loc5_.lastIndexOf("." + _loc1_));
            if(_loc2_ != -1 && _loc2_ + 1 + _loc1_.length == _loc5_.length)
            {
               _loc3_ = _loc5_.substring(0,_loc2_);
               _loc4_ = getProperty(_loc5_);
               setProperty(_loc3_,_loc4_);
            }
         }
      }
      
      private function fillParams(param1:String, param2:Dictionary) : String
      {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc7_:String = null;
         var _loc6_:String = null;
         _loc5_ = 0;
         while(_loc5_ < 10)
         {
            _loc3_ = int(param1.indexOf("%"));
            if(_loc3_ < 0)
            {
               break;
            }
            _loc4_ = int(param1.indexOf("%",_loc3_ + 1));
            if(_loc4_ < 0)
            {
               break;
            }
            _loc7_ = param1.substring(_loc3_ + 1,_loc4_);
            _loc6_ = param2[_loc7_];
            param1 = param1.replace("%" + _loc7_ + "%",_loc6_);
            _loc5_++;
         }
         return param1;
      }
      
      private function onConfigurationError(param1:Event = null) : void
      {
         var _loc3_:AssetLoaderEvent = param1 as AssetLoaderEvent;
         var _loc2_:int = 0;
         if(_loc3_ != null)
         {
            _loc2_ = _loc3_.status;
         }
         Logger.log(_loc3_.toString());
         HabboWebTools.logEventLog("external_variables download error " + _loc2_);
         Core.error("Could not load external variables. Failed to load URL " + getProperty("external.variables.txt") + " HTTP status " + _loc2_ + ". Client startup failed!",true,20);
      }
      
      private function onInitConfiguration(param1:Event = null) : void
      {
         var _loc2_:String = null;
         var _loc3_:ByteArray = null;
         var _loc4_:int = 0;
         if(disposed)
         {
            return;
         }
         var _loc5_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         if(_loc5_ == null)
         {
            return;
         }
         if(_loc5_.assetLoader.content is ByteArray)
         {
            _loc3_ = _loc5_.assetLoader.content as ByteArray;
            _loc3_.position = 0;
            _loc2_ = _loc3_.readUTFBytes(_loc3_.length);
         }
         else
         {
            _loc2_ = _loc5_.assetLoader.content as String;
         }
         if(_loc2_ != null)
         {
            parseConfiguration(_loc2_);
         }
         updateHabbiconAssetProperties();
         var _loc6_:ISoundAsset = assets.getAssetByName(_loc5_.assetName);
         if(_loc6_)
         {
            assets.removeAsset(_loc6_).dispose();
         }
         if(_loc2_ == null || _loc2_.length == 0)
         {
            _loc4_ = int(_loc2_ != null ? _loc2_.length : -1);
            Core.error("Could not load external variables, got empty data from URL " + getProperty("external.variables.txt") + " data length = " + _loc4_ + ". Client startup failed!",false,20);
         }
         if(!_isInitialized)
         {
            configurationsLoaded();
         }
      }
      
      private function configurationsLoaded() : void
      {
         events.dispatchEvent(new Event("HCE_CONFIGURATION_LOADED"));
         configurationsComplete();
      }
      
      private function configurationsComplete() : void
      {
         if(disposed)
         {
            return;
         }
         if(_isInitialized)
         {
            return;
         }
         _isInitialized = true;
         if(locked)
         {
            unlock();
         }
         events.dispatchEvent(new Event("complete"));
      }
      
      private function setDefaults() : void
      {
         var _loc1_:Array = null;
         ErrorReportStorage.addDebugData("Flashvars/host","Host: " + getProperty("connection.info.host"));
         ErrorReportStorage.addDebugData("Flashvars/port","Port: " + getProperty("connection.info.port"));
         setProperty("client.fatal.error.url","${url.prefix}/flash_client_error");
         setProperty("game.center.error.url","${url.prefix}/log/gameerror");
         var _loc2_:String = getProperty("flashclient.crossdomain.policy.files");
         if(_loc2_ && _loc2_ != "")
         {
            _loc1_ = _loc2_.split(",");
            for each(var _loc3_ in _loc1_)
            {
               _loc3_ = _loc3_.replace(" ","");
               Security.loadPolicyFile(_loc3_);
            }
         }
         updateHabbiconAssetProperties();
      }
      
      private function updateHabbiconAssetProperties() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         if(propertyExists("habbicons.hash"))
         {
            _loc2_ = getProperty("habbicons.hash");
            if(_loc2_ != null && _loc2_ != "")
            {
               setProperty("habbicons.asset.hash",_loc2_);
               _loc1_ = propertyExists("habbicons.url") ? getProperty("habbicons.url") : "https://images.habbo.com/habbicons";
               setProperty("habbicons.asset.root",_loc1_);
               return;
            }
         }
         if(_localization != null)
         {
            _loc1_ = _localization.getGameDataResourceUrl("habbicons");
            _loc2_ = _localization.getGameDataResourceHash("habbicons");
            if(_loc1_ != null && _loc1_ != "")
            {
               setProperty("habbicons.asset.root",_loc1_);
               if(_loc2_ != null && _loc2_ != "")
               {
                  setProperty("habbicons.asset.hash",_loc2_);
               }
               return;
            }
         }
         if(propertyExists("habbicons.asset.hash"))
         {
            setProperty("habbicons.asset.root","https://images.habbo.com/habbicons");
         }
      }
      
      private function parseDevelopmentVariables() : void
      {
      }
      
      private function parseCommonVariables() : void
      {
         parseConfigurationAsset("common_configuration");
      }
      
      private function parseConfigurationAsset(param1:String) : void
      {
         var _loc2_:TextAsset = assets.getAssetByName(param1) as TextAsset;
         if(_loc2_ != null)
         {
            parseConfiguration(_loc2_.content.toString());
         }
         else
         {
            Logger.log("Could not parse configuration " + param1);
         }
      }
      
      private function parseLocalizationVariables() : void
      {
         parseConfigurationAsset("localization_configuration");
      }
      
      private function parseArguments() : void
      {
         var _loc2_:String = null;
         var _loc1_:Dictionary = (context as ICoreComponentContext).arguments;
         for(var _loc3_ in _loc1_)
         {
            _loc2_ = _loc1_[_loc3_];
            _loc3_ = _loc3_.replace(/[_]/g,".");
            setProperty(_loc3_,_loc2_);
            if(UnknownVarFromHabboConfigurationManager_String_1 == null && _loc3_ == "environment.id")
            {
               UnknownVarFromHabboConfigurationManager_String_1 = _loc2_;
            }
         }
         (context as ICoreComponentContext).clearArguments();
      }
   }
}

