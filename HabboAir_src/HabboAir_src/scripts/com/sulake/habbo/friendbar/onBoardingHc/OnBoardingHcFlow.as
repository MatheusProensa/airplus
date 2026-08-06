package com.sulake.habbo.friendbar.onBoardingHc
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.friendbar.onBoardingHcSteps.AvatarEditor;
   import com.sulake.habbo.friendbar.onBoardingHcSteps.Background;
   import com.sulake.habbo.friendbar.onBoardingHcSteps.RoomPicker;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import onBoardingHcUi.LoaderUI;
   
   public class OnBoardingHcFlow extends Sprite implements IOnBoardingHcFlow, IComponentInterfaceQueue
   {
      public static const NEW_USER_FLOW_FINISHED_EVENT:String = "NewUserFlowFinished";
      
      private static const LOGO_AREA_HEIGHT:int = 95;
      
      private static const MAIN_AREA_MARGIN:int = 0;
      
      public static const AVATAR_NAME_CHANGE:int = 0;
      
      public static const NEW_ROOM_SELECT:int = 1;
      
      public static var ubuntu_regular:Class = §Ubuntu-R_3_ttf§;
      
      public static var ubuntu_bold:Class = §Ubuntu-B_1_ttf§;
      
      public static var ubuntu_italic:Class = §Ubuntu-I_3_ttf§;
      
      public static var ubuntu_bold_italic:Class = §Ubuntu-BI_3_ttf§;
      
      private static const habbo_logo_png:Class = logo_new_1_png;
      
      private var _background:Background;
      
      private var _avatarEditor:AvatarEditor;
      
      private var UnknownVarFromOnBoardingHcFlow_Sprite_1:Sprite;
      
      private var UnknownVarFromOnBoardingHcFlow_NameChangeDialog_1:NameChangeDialog;
      
      private var UnknownVarFromOnBoardingHcFlow_Sprite_2:Sprite;
      
      private var UnknownVarFromOnBoardingHcFlow_RoomPicker_1:RoomPicker;
      
      private var _disposed:Boolean;
      
      private var _avatarRenderManager:IAvatarRenderManager;
      
      private var _localizationManager:IHabboLocalizationManager;
      
      private var _communicationManager:IHabboCommunicationManager;
      
      private var UnknownVarFromOnBoardingHcFlow_Sprite_3:Sprite;
      
      private var UnknownVarFromOnBoardingHcFlow_Boolean_1:Boolean;
      
      private var UnknownVarFromOnBoardingHcFlow_Boolean_2:Boolean;
      
      private var _mainSprite:Sprite;
      
      private var UnknownVarFromOnBoardingHcFlow_Sprite_4:Sprite;
      
      private var _selectedName:String;
      
      private var _isFemale:Boolean;
      
      private var UnknownVarFromOnBoardingHcFlow_TextField_1:TextField;
      
      private var UnknownVarFromOnBoardingHcFlow_TextField_2:TextField;
      
      private var _showHcItems:Boolean;
      
      private var _nameAreaX:int = 535;
      
      private var _nameAreaWidth:int = 400;
      
      private var UnknownVarFromOnBoardingHcFlow_Array_1:Array = [];
      
      public function OnBoardingHcFlow(param1:IAvatarRenderManager, param2:IHabboLocalizationManager, param3:IHabboCommunicationManager)
      {
         super();
         _avatarRenderManager = param1;
         _localizationManager = param2;
         _communicationManager = param3;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(_background)
         {
            removeChild(_background);
            _background.dispose();
            _background = null;
         }
         if(_avatarEditor)
         {
            _avatarEditor.dispose();
            _avatarEditor = null;
         }
         if(UnknownVarFromOnBoardingHcFlow_NameChangeDialog_1)
         {
            UnknownVarFromOnBoardingHcFlow_NameChangeDialog_1.dispose();
            UnknownVarFromOnBoardingHcFlow_NameChangeDialog_1 = null;
         }
         if(UnknownVarFromOnBoardingHcFlow_Sprite_1)
         {
            UnknownVarFromOnBoardingHcFlow_Sprite_1 = null;
         }
         if(UnknownVarFromOnBoardingHcFlow_Sprite_2 != null)
         {
            UnknownVarFromOnBoardingHcFlow_Sprite_2 = null;
         }
         if(_mainSprite != null)
         {
            removeChild(_mainSprite);
            _mainSprite = null;
         }
         _avatarRenderManager = null;
         _localizationManager = null;
         _communicationManager = null;
         stage.removeChild(this);
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function init(param1:Array) : void
      {
         UnknownVarFromOnBoardingHcFlow_Array_1 = param1;
         stage.addEventListener("resize",onStageResize);
         _background = new Background();
         addChild(_background);
         UnknownVarFromOnBoardingHcFlow_Sprite_4 = new Sprite();
         addChild(UnknownVarFromOnBoardingHcFlow_Sprite_4);
         var _loc2_:Bitmap = new habbo_logo_png();
         _loc2_.x = 40;
         _loc2_.y = 40;
         UnknownVarFromOnBoardingHcFlow_Sprite_4.addChild(_loc2_);
         _mainSprite = new Sprite();
         addChild(_mainSprite);
         _mainSprite.y = 95;
         _mainSprite.x = 0;
         _avatarEditor = new AvatarEditor(this);
         _avatarEditor.showHcItems(_showHcItems);
         _mainSprite.addChild(_avatarEditor);
         UnknownVarFromOnBoardingHcFlow_Sprite_1 = new Sprite();
         UnknownVarFromOnBoardingHcFlow_Sprite_1.x = _nameAreaX;
         UnknownVarFromOnBoardingHcFlow_Sprite_1.y = 95;
         UnknownVarFromOnBoardingHcFlow_Sprite_1.visible = true;
         _mainSprite.addChild(UnknownVarFromOnBoardingHcFlow_Sprite_1);
         UnknownVarFromOnBoardingHcFlow_Sprite_2 = new Sprite();
         UnknownVarFromOnBoardingHcFlow_Sprite_2.x = 0;
         UnknownVarFromOnBoardingHcFlow_Sprite_2.y = 95;
         UnknownVarFromOnBoardingHcFlow_Sprite_2.visible = false;
         _mainSprite.addChild(UnknownVarFromOnBoardingHcFlow_Sprite_2);
         if(isRoomPickingNeeded)
         {
            UnknownVarFromOnBoardingHcFlow_RoomPicker_1 = new RoomPicker(this,UnknownVarFromOnBoardingHcFlow_Sprite_2);
            UnknownVarFromOnBoardingHcFlow_RoomPicker_1.fetchThumbnails();
         }
         if(!UnknownVarFromOnBoardingHcFlow_Array_1)
         {
            dispatchEvent(new Event("NewUserFlowFinished"));
            return;
         }
         if(UnknownVarFromOnBoardingHcFlow_Array_1.indexOf(0) >= 0)
         {
         }
         if(UnknownVarFromOnBoardingHcFlow_Array_1.indexOf(1) >= 0)
         {
         }
         if(UnknownVarFromOnBoardingHcFlow_Array_1.indexOf(0) >= 0)
         {
            startNameChange();
         }
         else
         {
            startRoomPicking();
         }
      }
      
      public function setHcVisibility(param1:Boolean) : void
      {
         _showHcItems = param1;
      }
      
      private function onStageResize(param1:Event) : void
      {
         if(disposed)
         {
            return;
         }
         layoutMainElements();
      }
      
      private function layoutMainElements() : void
      {
         var _loc2_:int = 0;
         if(_background != null)
         {
            _background.resize();
         }
         if(UnknownVarFromOnBoardingHcFlow_Sprite_2)
         {
            UnknownVarFromOnBoardingHcFlow_Sprite_2.x = 0;
         }
         if(!UnknownVarFromOnBoardingHcFlow_TextField_1)
         {
            UnknownVarFromOnBoardingHcFlow_TextField_1 = LoaderUI.createTextField("intro",40,16777215,false,true,false,false,"left");
            UnknownVarFromOnBoardingHcFlow_TextField_1.x = 185;
            UnknownVarFromOnBoardingHcFlow_TextField_1.y = 45;
            UnknownVarFromOnBoardingHcFlow_TextField_1.width = 500;
            UnknownVarFromOnBoardingHcFlow_TextField_1.multiline = false;
            UnknownVarFromOnBoardingHcFlow_TextField_1.thickness = 50;
            UnknownVarFromOnBoardingHcFlow_Sprite_4.addChild(UnknownVarFromOnBoardingHcFlow_TextField_1);
         }
         var _loc1_:int = _mainSprite.width + 20;
         if(stage.stageWidth > _loc1_)
         {
            _loc2_ = (stage.stageWidth - _loc1_) / 2;
            if(_loc2_ < 0)
            {
               _loc2_ = 0;
            }
            _mainSprite.x = _loc2_;
         }
         else
         {
            _mainSprite.x = 0;
         }
         if(_avatarEditor)
         {
            _avatarEditor.x = 0;
            _nameAreaX = _avatarEditor.x + _avatarEditor.width - 125;
         }
         if(UnknownVarFromOnBoardingHcFlow_Sprite_1)
         {
            UnknownVarFromOnBoardingHcFlow_Sprite_1.x = _nameAreaX;
         }
         _mainSprite.y = 95;
      }
      
      public function getLocalization(param1:String, param2:String = null) : String
      {
         if(!_localizationManager)
         {
            return param2;
         }
         return _localizationManager.getLocalization(param1,param2);
      }
      
      public function getProperty(param1:String, param2:String = null) : String
      {
         if(!_localizationManager)
         {
            return param2;
         }
         var _loc3_:String = _localizationManager.getProperty(param1);
         return !!_loc3_ ? _loc3_ : param2;
      }
      
      public function showErrorMessage(param1:String) : void
      {
         var _loc3_:TextField = LoaderUI.createTextField(param1,9,16777215,true);
         LoaderUI.addEtching(_loc3_,true);
         var _loc2_:Bitmap = LoaderUI.createBalloon(_loc3_.width + 30,_loc3_.height + 17,-1,true,11411485);
         if(UnknownVarFromOnBoardingHcFlow_Sprite_3)
         {
            removeChild(UnknownVarFromOnBoardingHcFlow_Sprite_3);
         }
         UnknownVarFromOnBoardingHcFlow_Sprite_3 = new Sprite();
         UnknownVarFromOnBoardingHcFlow_Sprite_3.addChild(_loc2_);
         UnknownVarFromOnBoardingHcFlow_Sprite_3.addChild(_loc3_);
         _loc3_.x = 15;
         _loc3_.y = 14;
         _mainSprite.addChild(UnknownVarFromOnBoardingHcFlow_Sprite_3);
         UnknownVarFromOnBoardingHcFlow_Sprite_3.x = 766;
         UnknownVarFromOnBoardingHcFlow_Sprite_3.y = 577;
         UnknownVarFromOnBoardingHcFlow_Sprite_3.filters = [new GlowFilter(0,0.24,6,6)];
      }
      
      public function get avatarRenderManager() : IAvatarRenderManager
      {
         return _avatarRenderManager;
      }
      
      public function get selectedName() : String
      {
         return _selectedName;
      }
      
      public function get isFemale() : Boolean
      {
         return _isFemale;
      }
      
      public function get communicationManager() : IHabboCommunicationManager
      {
         return _communicationManager;
      }
      
      public function editorFinished() : void
      {
         if(isRoomPickingNeeded)
         {
            startRoomPicking();
         }
         else
         {
            dispatchEvent(new Event("NewUserFlowFinished"));
         }
      }
      
      public function setHcMembership(param1:Boolean) : void
      {
         UnknownVarFromOnBoardingHcFlow_Boolean_1 = param1;
      }
      
      public function submitName() : void
      {
         if(UnknownVarFromOnBoardingHcFlow_NameChangeDialog_1 != null && UnknownVarFromOnBoardingHcFlow_Sprite_1.visible)
         {
            UnknownVarFromOnBoardingHcFlow_NameChangeDialog_1.submitName();
         }
         else
         {
            nameChangeCompleted();
            editorFinished();
         }
      }
      
      private function startNameChange() : void
      {
         if(!UnknownVarFromOnBoardingHcFlow_NameChangeDialog_1)
         {
            UnknownVarFromOnBoardingHcFlow_NameChangeDialog_1 = new HitchNameChangeDialog(this,UnknownVarFromOnBoardingHcFlow_Sprite_1,getNameAreaWidth());
         }
         if(UnknownVarFromOnBoardingHcFlow_Sprite_2)
         {
            UnknownVarFromOnBoardingHcFlow_Sprite_2.visible = false;
         }
         UnknownVarFromOnBoardingHcFlow_Sprite_1.visible = true;
         UnknownVarFromOnBoardingHcFlow_Sprite_1.x = _nameAreaX;
         UnknownVarFromOnBoardingHcFlow_NameChangeDialog_1.preSelectedGender = _avatarEditor.gender;
         layoutMainElements();
         showChooseStyleHeader();
      }
      
      public function setNameGender(param1:String, param2:Boolean) : void
      {
         _selectedName = param1;
         _isFemale = param2;
      }
      
      public function setIsFemale(param1:Boolean) : void
      {
         _isFemale = param1;
      }
      
      public function nameChangeCompleted(param1:Boolean = true) : void
      {
         UnknownVarFromOnBoardingHcFlow_Boolean_2 = param1;
         _avatarEditor.nameChangeCompleted(param1);
      }
      
      public function showHideButtons(param1:Boolean) : void
      {
         _avatarEditor.showHideButtons(param1);
      }
      
      private function get isRoomPickingNeeded() : Boolean
      {
         return UnknownVarFromOnBoardingHcFlow_Array_1.indexOf(1) >= 0;
      }
      
      private function startRoomPicking() : void
      {
         if(UnknownVarFromOnBoardingHcFlow_RoomPicker_1 == null)
         {
            return;
         }
         _avatarEditor.visible = false;
         _avatarEditor.showHideGrid(false);
         UnknownVarFromOnBoardingHcFlow_Sprite_1.visible = false;
         UnknownVarFromOnBoardingHcFlow_Sprite_2.visible = true;
         UnknownVarFromOnBoardingHcFlow_RoomPicker_1.init();
         layoutMainElements();
         showPickRoomHeader();
      }
      
      public function showPickRoomHeader() : void
      {
         if(UnknownVarFromOnBoardingHcFlow_TextField_1)
         {
            UnknownVarFromOnBoardingHcFlow_TextField_1.width = 650;
            UnknownVarFromOnBoardingHcFlow_TextField_1.htmlText = getLocalization("onboarding.choose.your.room","Choose your room");
         }
      }
      
      public function showChooseStyleHeader() : void
      {
         if(UnknownVarFromOnBoardingHcFlow_TextField_1)
         {
            UnknownVarFromOnBoardingHcFlow_TextField_1.width = 650;
            UnknownVarFromOnBoardingHcFlow_TextField_1.htmlText = getLocalization("onboarding.choose.your.style","My looks");
         }
      }
      
      public function roomPickingCompleted() : void
      {
         dispatchEvent(new Event("NewUserFlowFinished"));
      }
      
      public function get debugText() : TextField
      {
         return null;
      }
      
      public function getNameAreaX() : int
      {
         return _nameAreaX;
      }
      
      public function getNameAreaWidth() : int
      {
         return _nameAreaWidth;
      }
   }
}

