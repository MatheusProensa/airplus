package
{
   import com.sulake.core.assets.AssetLibrary;
   import com.sulake.core.assets.AssetLibraryCollection;
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.habbo.configuration.HabboConfigurationManager;
   import com.sulake.habbo.localization.HabboLocalizationManager;
   import flash.desktop.NativeApplication;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import onBoardingHcUi.LoaderUI;
   import splash.PhotoSplashScreen;
   
   public class HabboLoadingScreen extends Sprite implements IComponentInterfaceQueue, IHabboLoadingScreen
   {
      private static const UnknownConstFromHabboLoadingScreen_Int_1:int = 28;
      
      public static const LOADING_BAR_WIDTH:int = 400;
      
      public static const LOADING_BAR_HEIGHT:int = 25;
      
      public static const LOADING_BAR_BORDER_WIDTH:int = 2;
      
      public static const LOADING_BAR_BORDER_SPACING:int = 2;
      
      public static const CONTAINER:String = "container";
      
      public static const FILE_LOADING_BAR:String = "fileLoadingBar";
      
      public static const FILE_BAR_SPRITE:String = "fileBarSprite";
      
      public static const PHOTO_SPLASH_SCREEN:String = "photoSplashScreen";
      
      public static const BACKGROUND:String = "background";
      
      public static const UnknownConstFromHabboLoadingScreen_String_1:String = "habboLogo";
      
      public static const UnknownConstFromHabboLoadingScreen_String_2:String = "textField";
      
      public static const VERSION_TEXT_FIELD:String = "versionTextField";
      
      public static const UnknownConstFromHabboLoadingScreen_String_3:String = "loadingNumberTextField";
      
      public static const ERROR_TEXT_FIELD:String = "errorTextField";
      
      private var UnknownVarFromHabboLoadingScreen_Timer_1:Timer;
      
      private var UnknownVarFromHabboLoadingScreen_Int_1:int = 0;
      
      private var UnknownVarFromHabboLoadingScreen_PhotoSplashScreen_1:PhotoSplashScreen;
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromHabboLoadingScreen_Int_2:int = 0;
      
      private var UnknownVarFromHabboLoadingScreen_String_1:String = null;
      
      private var UnknownVarFromHabboLoadingScreen_IComponent_2_1:IComponent_2;
      
      private var UnknownVarFromHabboLoadingScreen_HabboConfigurationManager_1:HabboConfigurationManager;
      
      private var _localization:HabboLocalizationManager;
      
      private var UnknownVarFromHabboLoadingScreen_Boolean_1:Boolean = false;
      
      public function HabboLoadingScreen(param1:int, param2:int, param3:Dictionary)
      {
         var _loc5_:Sprite = null;
         var _loc13_:Sprite = null;
         var _loc9_:Array = null;
         super();
         createFakeContext(param3);
         var _loc14_:Sprite = new Sprite();
         _loc14_.name = "background";
         _loc14_.graphics.clear();
         _loc14_.graphics.beginFill(1312787);
         _loc14_.graphics.drawRect(0,0,param1,param2);
         addChild(_loc14_);
         UnknownVarFromHabboLoadingScreen_PhotoSplashScreen_1 = new PhotoSplashScreen(this);
         UnknownVarFromHabboLoadingScreen_PhotoSplashScreen_1.name = "photoSplashScreen";
         addChild(UnknownVarFromHabboLoadingScreen_PhotoSplashScreen_1);
         _loc5_ = new Sprite();
         _loc5_.name = "fileLoadingBar";
         _loc5_.graphics.lineStyle(1,16777215,1,true);
         _loc5_.graphics.beginFill(2500143);
         _loc5_.graphics.drawRect(1,0,400 - 1,0);
         _loc5_.graphics.drawRect(400,1,0,25 - 1);
         _loc5_.graphics.drawRect(1,25,400 - 1,0);
         _loc5_.graphics.drawRect(0,1,0,25 - 1);
         _loc5_.graphics.endFill();
         addChild(_loc5_);
         var _loc10_:String = _localization.getLocalization("client.starting.revolving");
         var _loc4_:String = _localization.getLocalization("client.starting");
         var _loc11_:* = null;
         if(_loc10_ != null)
         {
            _loc9_ = _loc10_.split("/");
            UnknownVarFromHabboLoadingScreen_Int_2 = randomNumber(0,_loc9_.length - 1);
            UnknownVarFromHabboLoadingScreen_String_1 = _loc10_;
            _loc11_ = _loc9_[UnknownVarFromHabboLoadingScreen_Int_2];
         }
         else
         {
            _loc11_ = _loc4_;
         }
         var _loc6_:TextField = LoaderUI.createTextField(_loc11_,28,16777215,true,false,false,false,"center");
         _loc6_.name = "textField";
         addChild(_loc6_);
         var _loc7_:TextField = LoaderUI.createTextField("0%",14,10066329,true,false,false,false,"center");
         _loc7_.name = "loadingNumberTextField";
         addChild(_loc7_);
         _loc13_ = new Sprite();
         _loc13_.name = "fileBarSprite";
         _loc5_.addChild(_loc13_);
         _loc5_.visible = true;
         var _loc12_:XML = NativeApplication.nativeApplication.applicationDescriptor;
         var _loc8_:Namespace = _loc12_.namespace();
         var _loc16_:String = _loc12_._loc8_::versionNumber;
         var _loc15_:TextField = LoaderUI.createTextField(_loc16_,12,10066329,true,false,false,false,"right");
         _loc15_.name = "versionTextField";
         addChild(_loc15_);
         addEventListener("addedToStage",onAddedToStage);
      }
      
      private function createFakeContext(param1:Dictionary) : void
      {
         UnknownVarFromHabboLoadingScreen_IComponent_2_1 = new FakeContext(param1);
         var _loc3_:XML = <manifest><library /></manifest>;
         var _loc2_:IAssetLibraryCollection = new AssetLibrary("_assetsTemp@",_loc3_);
         (UnknownVarFromHabboLoadingScreen_IComponent_2_1.assets as AssetLibraryCollection).addAssetLibrary(_loc2_);
         UnknownVarFromHabboLoadingScreen_HabboConfigurationManager_1 = createConfiguration(UnknownVarFromHabboLoadingScreen_IComponent_2_1);
         _localization = createLocalization(UnknownVarFromHabboLoadingScreen_IComponent_2_1);
         _localization.loadDefaultEmbedLocalizations(UnknownVarFromHabboLoadingScreen_HabboConfigurationManager_1.getProperty("environment.id"));
      }
      
      private function createConfiguration(param1:IComponent_2) : HabboConfigurationManager
      {
         var _loc5_:XML = <manifest><library /></manifest>;
         var _loc2_:ByteArray = new HabboConfigurationCom.manifest() as ByteArray;
         var _loc3_:XML = new XML(_loc2_.readUTFBytes(_loc2_.length));
         _loc5_.library.appendChild(_loc3_.component.assets);
         var _loc4_:IAssetLibraryCollection = new AssetLibrary("_assetsConfiguration@");
         _loc4_.loadFromResource(_loc5_,HabboConfigurationCom);
         return new HabboConfigurationManager(param1,0,_loc4_);
      }
      
      private function createLocalization(param1:IComponent_2) : HabboLocalizationManager
      {
         var _loc5_:XML = <manifest><library /></manifest>;
         var _loc2_:ByteArray = new HabboLocalizationCom.manifest() as ByteArray;
         var _loc3_:XML = new XML(_loc2_.readUTFBytes(_loc2_.length));
         _loc5_.library.appendChild(_loc3_.component.assets);
         var _loc4_:IAssetLibraryCollection = new AssetLibrary("_assetsLocalization@");
         _loc4_.loadFromResource(_loc5_,HabboLocalizationCom);
         return new HabboLocalizationManager(param1,0,_loc4_);
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         Logger.log("Habbo Loading Screen was removed from stage.");
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         removeEventListener("addedToStage",onAddedToStage);
         stage.addEventListener("resize",onResize);
         positionLoadingScreenDisplayElements();
         UnknownVarFromHabboLoadingScreen_Timer_1 = new Timer(750);
         UnknownVarFromHabboLoadingScreen_Timer_1.addEventListener("timer",onBarProgressEvent);
         UnknownVarFromHabboLoadingScreen_Timer_1.start();
      }
      
      private function onResize(param1:Event) : void
      {
         positionLoadingScreenDisplayElements();
      }
      
      private function onBarProgressEvent(param1:Event) : void
      {
         var _loc4_:Array = null;
         var _loc2_:TextField = null;
         var _loc3_:TextField = null;
         if(UnknownVarFromHabboLoadingScreen_Int_1 == 100)
         {
            if(UnknownVarFromHabboLoadingScreen_Boolean_1)
            {
               _loc4_ = UnknownVarFromHabboLoadingScreen_String_1.split("/");
               _loc2_ = getChildByName("textField") as TextField;
               if(_loc2_ != null)
               {
                  removeElement("textField");
                  _loc3_ = LoaderUI.createTextField(_loc4_[UnknownVarFromHabboLoadingScreen_Int_2],28,16777215,true,false,false,false,"center");
                  _loc3_.x = (width - _loc3_.width) / 2;
                  _loc3_.y = _loc2_.y;
                  _loc3_.name = "textField";
                  addChild(_loc3_);
               }
               UnknownVarFromHabboLoadingScreen_Boolean_1 = false;
            }
            UnknownVarFromHabboLoadingScreen_Int_1 = 0;
         }
         else
         {
            UnknownVarFromHabboLoadingScreen_Int_1 += Math.min(randomNumber(35,Math.min(randomNumber(45,55))),100 - UnknownVarFromHabboLoadingScreen_Int_1);
         }
         if(UnknownVarFromHabboLoadingScreen_Int_1 == 100 && UnknownVarFromHabboLoadingScreen_String_1 != null)
         {
            UnknownVarFromHabboLoadingScreen_Boolean_1 = true;
            UnknownVarFromHabboLoadingScreen_Int_2 = (UnknownVarFromHabboLoadingScreen_Int_2 + 1) % (UnknownVarFromHabboLoadingScreen_String_1.split("/").length - 1);
         }
         updateLoadingBarProgression(UnknownVarFromHabboLoadingScreen_Int_1 / 100);
      }
      
      private function randomNumber(param1:Number, param2:Number) : Number
      {
         return Math.floor(Math.random() * (param2 - param1 + 1)) + param1;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function removeElement(param1:String) : void
      {
         var _loc2_:DisplayObject = getChildByName(param1);
         if(_loc2_ != null)
         {
            removeChild(_loc2_);
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         if(disposed)
         {
            return;
         }
         _disposed = true;
         _loc1_ = _loc1_;
         if(_loc1_ != null)
         {
            _loc1_.removeEventListener("resize",onResize);
         }
         removeEventListener("addedToStage",onAddedToStage);
         removeEventListener("removedFromStage",onRemovedFromStage);
         removeElement("photoSplashScreen");
         removeElement("background");
         removeElement("textField");
         removeElement("habboLogo");
         removeElement("fileLoadingBar");
         removeElement("errorTextField");
         removeElement("container");
         if(UnknownVarFromHabboLoadingScreen_Timer_1 != null)
         {
            UnknownVarFromHabboLoadingScreen_Timer_1.stop();
            UnknownVarFromHabboLoadingScreen_Timer_1.removeEventListener("timer",onBarProgressEvent);
            UnknownVarFromHabboLoadingScreen_Timer_1 = null;
         }
         if(UnknownVarFromHabboLoadingScreen_IComponent_2_1)
         {
            UnknownVarFromHabboLoadingScreen_IComponent_2_1.dispose();
            UnknownVarFromHabboLoadingScreen_IComponent_2_1 = null;
         }
         if(_localization)
         {
            _localization.dispose();
            _localization = null;
         }
         if(UnknownVarFromHabboLoadingScreen_HabboConfigurationManager_1)
         {
            UnknownVarFromHabboLoadingScreen_HabboConfigurationManager_1.dispose();
            UnknownVarFromHabboLoadingScreen_HabboConfigurationManager_1 = null;
         }
         if(parent != null)
         {
            parent.removeChild(this);
         }
      }
      
      public function positionLoadingScreenDisplayElements() : void
      {
         var _loc12_:int = 0;
         var _loc15_:int = 0;
         var _loc9_:Stage = this.stage;
         if(_loc9_ != null)
         {
            _loc12_ = _loc9_.stageWidth;
            _loc15_ = _loc9_.stageHeight;
         }
         else
         {
            _loc12_ = this.width;
            _loc15_ = this.height;
         }
         var _loc10_:Sprite = getChildByName("background") as Sprite;
         if(_loc10_ != null)
         {
            _loc10_.x = 0;
            _loc10_.y = 0;
            _loc10_.graphics.clear();
            _loc10_.graphics.beginFill(1312787);
            _loc10_.graphics.drawRect(0,0,_loc12_,_loc15_);
         }
         var _loc16_:int = 0;
         var _loc7_:int = 0;
         var _loc13_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:int = 10;
         var _loc8_:Sprite = getChildByName("photoSplashScreen") as Sprite;
         if(_loc8_ != null)
         {
            _loc8_.x = (_loc12_ - _loc8_.width) / 2;
            _loc2_ = _loc8_.y + _loc8_.height;
         }
         var _loc6_:TextField = getChildByName("textField") as TextField;
         if(_loc6_ != null)
         {
            _loc6_.x = (_loc12_ - _loc6_.width) / 2;
            if(_loc6_.width > _loc13_)
            {
               _loc13_ = _loc6_.width;
               _loc16_ = _loc6_.x;
            }
         }
         var _loc3_:TextField = getChildByName("versionTextField") as TextField;
         if(_loc3_ != null)
         {
            _loc3_.x = _loc12_ - _loc3_.width;
            _loc3_.y = 0;
         }
         var _loc14_:Sprite = getChildByName("fileLoadingBar") as Sprite;
         if(_loc14_ != null)
         {
            _loc14_.x = (_loc12_ - _loc14_.width) / 2;
            _loc14_.y = _loc2_;
            _loc2_ = _loc14_.y + _loc14_.height;
            if(_loc14_.width > _loc13_)
            {
               _loc13_ = _loc14_.width;
               _loc16_ = _loc14_.x;
            }
         }
         var _loc11_:TextField = getChildByName("loadingNumberTextField") as TextField;
         if(_loc11_ != null)
         {
            _loc11_.x = (_loc12_ - _loc11_.width) / 2;
            if(_loc11_.width > _loc13_)
            {
               _loc13_ = _loc11_.width;
               _loc16_ = _loc11_.x;
            }
         }
         var _loc1_:TextField = getChildByName("errorTextField") as TextField;
         if(_loc1_ != null)
         {
            _loc1_.x = (_loc12_ - _loc1_.width) / 2;
            if(_loc1_.width > _loc13_)
            {
               _loc13_ = _loc1_.width;
               _loc16_ = _loc1_.x;
            }
         }
         _loc2_ = (_loc15_ - _loc2_) / 2;
         _loc2_ -= _loc4_ * 2;
         if(_loc8_ != null)
         {
            _loc8_.y = _loc2_;
            _loc2_ = _loc8_.y + _loc8_.height;
         }
         if(_loc6_ != null)
         {
            _loc6_.y = _loc2_ + 50;
            _loc2_ = _loc6_.y + _loc6_.height + _loc4_;
         }
         if(_loc14_ != null)
         {
            _loc14_.y = _loc2_;
            _loc2_ = _loc14_.y + _loc14_.height + _loc4_ / 2;
         }
         if(_loc11_ != null)
         {
            _loc11_.y = _loc2_;
            _loc2_ = _loc11_.y + _loc11_.height + _loc4_;
         }
         if(_loc1_ != null)
         {
            _loc1_.y = _loc2_;
         }
      }
      
      public function updateLoadingBarProgression(param1:Number) : void
      {
         var _loc6_:int = 400;
         var _loc9_:int = 25;
         var _loc5_:int = 2;
         var _loc3_:int = 2;
         var _loc8_:Sprite = getChildByName("fileLoadingBar") as Sprite;
         if(_loc8_ == null)
         {
            return;
         }
         var _loc7_:Sprite = _loc8_.getChildByName("fileBarSprite") as Sprite;
         if(_loc7_ == null)
         {
            return;
         }
         _loc7_.x = _loc5_ + _loc3_;
         _loc7_.y = _loc5_ + _loc3_;
         _loc7_.graphics.clear();
         var _loc4_:int = _loc9_ - _loc5_ * 2 - _loc3_ * 2;
         var _loc2_:int = (_loc6_ - _loc5_ * 2 - _loc3_ * 2) * param1;
         _loc7_.graphics.beginFill(0);
         _loc7_.graphics.drawRect(-1,-1,_loc6_ - _loc5_ * 2,_loc9_ - _loc3_ * 2);
         _loc7_.graphics.endFill();
         _loc7_.graphics.beginFill(16752370);
         _loc7_.graphics.drawRect(0,0,_loc2_,_loc4_ / 2);
         _loc7_.graphics.endFill();
         _loc7_.graphics.beginFill(16739307);
         _loc7_.graphics.drawRect(0,_loc4_ / 2,_loc2_,_loc4_ / 2 + 1);
         _loc7_.graphics.endFill();
      }
      
      public function updateLoadingBar(param1:Number) : void
      {
         var _loc2_:TextField = getChildByName("loadingNumberTextField") as TextField;
         if(_loc2_ != null)
         {
            _loc2_.text = Math.round(param1 * 100) + "%";
         }
      }
      
      public function showError(param1:String) : void
      {
         if(UnknownVarFromHabboLoadingScreen_Timer_1 != null)
         {
            UnknownVarFromHabboLoadingScreen_Timer_1.stop();
            UnknownVarFromHabboLoadingScreen_Timer_1.removeEventListener("timer",onBarProgressEvent);
            UnknownVarFromHabboLoadingScreen_Timer_1 = null;
         }
         var _loc2_:TextField = getChildByName("textField") as TextField;
         if(_loc2_ != null)
         {
            _loc2_.htmlText = "${client.loading.failed}";
            if(_loc2_.text == "" || _loc2_.text == "client.loading.failed" || _loc2_.text == "${client.loading.failed}")
            {
               _loc2_.text = "Loading failed";
            }
            _loc2_.width = _loc2_.textWidth + 6;
            _loc2_.height = _loc2_.textHeight + 6;
         }
         var _loc5_:TextField = getChildByName("loadingNumberTextField") as TextField;
         if(_loc5_ != null)
         {
            _loc5_.text = "";
         }
         var _loc3_:TextField = getChildByName("errorTextField") as TextField;
         if(_loc3_ == null)
         {
            _loc3_ = LoaderUI.createTextField("",16,8309486,false,true,false,false,"center");
            _loc3_.name = "errorTextField";
            addChild(_loc3_);
         }
         var _loc4_:int = int(stage != null ? stage.stageWidth : width);
         _loc3_.autoSize = "none";
         _loc3_.multiline = true;
         _loc3_.wordWrap = true;
         _loc3_.width = Math.max(320,Math.min(_loc4_ - 80,760));
         _loc3_.text = param1;
         _loc3_.height = _loc3_.textHeight + 10;
         positionLoadingScreenDisplayElements();
      }
   }
}

