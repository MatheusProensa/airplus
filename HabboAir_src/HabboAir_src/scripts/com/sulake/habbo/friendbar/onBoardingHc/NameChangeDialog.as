package com.sulake.habbo.friendbar.onBoardingHc
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.habbo.communication.messages.incoming.avatar.ChangeUserNameResultMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.avatar.CheckUserNameResultMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.avatar.ChangeUserNameMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.avatar.CheckUserNameMessageComposer;
   import com.sulake.habbo.communication.messages.parser.avatar.ChangeUserNameResultMessageParser;
   import com.sulake.habbo.communication.messages.parser.avatar.CheckUserNameResultMessageParser;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.utils.Timer;
   import onBoardingHcUi.Button;
   import onBoardingHcUi.Dimmer;
   import onBoardingHcUi.LoaderUI;
   import onBoardingHcUi.NineSplitSprite;
   import onBoardingHcUi.WaitIndicator;
   
   public class NameChangeDialog implements IComponentInterfaceQueue
   {
      private static const IDLE_TIME_MS:int = 500;
      
      private var input_error_alert_hitch_png:Class = input_error_alert_hitch_1_png;
      
      protected var _style:int = 1;
      
      private var _disposed:Boolean;
      
      protected var _context:IOnBoardingHcFlow;
      
      private var UnknownVarFromNameChangeDialog_Boolean_1:Boolean;
      
      protected var UnknownVarFromNameChangeDialog_Sprite_1:Sprite;
      
      private var _dimmer:Dimmer;
      
      protected var UnknownVarFromNameChangeDialog_TextField_1:TextField;
      
      protected var _submitButton:Button;
      
      protected var _skipButton:Button;
      
      private var UnknownVarFromNameChangeDialog_Sprite_2:Sprite;
      
      protected var UnknownVarFromNameChangeDialog_Bitmap_1:Bitmap;
      
      protected var UnknownVarFromNameChangeDialog_Bitmap_2:Bitmap;
      
      private var _inputClickedAlready:Boolean;
      
      protected var UnknownVarFromNameChangeDialog_Bitmap_3:Bitmap;
      
      private var UnknownVarFromNameChangeDialog_Timer_1:Timer;
      
      protected var UnknownVarFromNameChangeDialog_WaitIndicator_1:WaitIndicator;
      
      protected var _container:Sprite;
      
      private var UnknownVarFromNameChangeDialog_String_1:String;
      
      protected var _inputDefaultString:String;
      
      protected var UnknownVarFromNameChangeDialog_Sprite_3:Sprite;
      
      protected var _dialogWidth:int;
      
      private var UnknownVarFromNameChangeDialog_IMessageEvent_1:IMessageEvent;
      
      private var UnknownVarFromNameChangeDialog_IMessageEvent_2:IMessageEvent;
      
      public function NameChangeDialog(param1:IOnBoardingHcFlow, param2:Sprite, param3:int)
      {
         super();
         _context = param1;
         _container = param2;
         _dialogWidth = param3;
         init();
         UnknownVarFromNameChangeDialog_IMessageEvent_1 = param1.communicationManager.addHabboConnectionMessageEvent(new ChangeUserNameResultMessageEvent(onChangeUserNameResult));
         UnknownVarFromNameChangeDialog_IMessageEvent_2 = param1.communicationManager.addHabboConnectionMessageEvent(new CheckUserNameResultMessageEvent(onCheckUserNameResult));
         UnknownVarFromNameChangeDialog_Timer_1 = new Timer(500,1);
         UnknownVarFromNameChangeDialog_Timer_1.addEventListener("timer",onIdleTimer);
      }
      
      private function onChangeUserNameResult(param1:ChangeUserNameResultMessageEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:ChangeUserNameResultMessageParser = param1.getParser();
         if(_loc2_ == null)
         {
            return;
         }
         claimNameResponse(_loc2_.resultCode,_loc2_.name,_loc2_.nameSuggestions);
      }
      
      private function onCheckUserNameResult(param1:CheckUserNameResultMessageEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:CheckUserNameResultMessageParser = param1.getParser();
         if(_loc2_ == null)
         {
            return;
         }
         checkNameResponse(_loc2_.resultCode,_loc2_.name,_loc2_.nameSuggestions);
      }
      
      protected function init() : void
      {
         var _loc5_:Bitmap = null;
         UnknownVarFromNameChangeDialog_Sprite_1 = LoaderUI.createFrame(_context.getLocalization("rename.title","Pick a name for your character"),"",new Rectangle(-_dialogWidth / 2,0,_dialogWidth,1),_style);
         var _loc4_:int = 23;
         var _loc3_:int = _dialogWidth - _loc4_ * 2;
         var _loc1_:int = _dialogWidth - 12;
         UnknownVarFromNameChangeDialog_Sprite_1.x = 5;
         var _loc10_:Boolean = false;
         var _loc6_:TextField = LoaderUI.createTextField(_context.getLocalization("rename.subtitle","You are a unique and beautiful snowflake."),20,0,true,false,false,_loc10_);
         _loc6_.x = _loc4_;
         LoaderUI.addEtching(_loc6_);
         var _loc8_:TextField = LoaderUI.createTextField(_context.getLocalization("rename.description","In Habbo, we all sign in using a unique name, so go ahead and enter yours. There\'s no need to use your real one - stage names are perfectly ok."),12,0,false,true,false,_loc10_);
         UnknownVarFromNameChangeDialog_Sprite_1.addChild(_loc8_);
         _loc8_.x = _loc4_;
         _loc8_.width = _loc3_;
         LoaderUI.addEtching(_loc8_);
         var _loc2_:Sprite = new Sprite();
         UnknownVarFromNameChangeDialog_Bitmap_3 = NineSplitSprite.INPUT_FIELD.render(_loc3_,50);
         _loc2_.addChild(UnknownVarFromNameChangeDialog_Bitmap_3);
         UnknownVarFromNameChangeDialog_Sprite_1.addChild(_loc2_);
         _loc2_.x = _loc4_;
         var _loc7_:TextField = LoaderUI.createTextField(_context.getLocalization("rename.accepted","WE ACCEPT LETTERS AND NUMBERS. NOT VISA OR MASTERCARD."),9,4342338,true,false,false,_loc10_);
         UnknownVarFromNameChangeDialog_Sprite_1.addChild(_loc7_);
         _loc7_.x = _loc4_ + 5;
         LoaderUI.addEtching(_loc7_);
         var _loc11_:TextField = LoaderUI.createTextField(_context.getLocalization("rename.warning","Once you\'ve selected a name for your character, you can\'t change it anymore, so please pay a bit of attention to your selection."),16,4342338,false,true,false,false);
         _loc11_.width = _loc3_ - 66;
         LoaderUI.addEtching(_loc11_);
         _loc5_ = NineSplitSprite.BORDER_SUNK.render(_loc3_,_loc11_.height + 24);
         UnknownVarFromNameChangeDialog_Sprite_3 = new Sprite();
         if(_loc5_)
         {
            UnknownVarFromNameChangeDialog_Sprite_3.addChild(_loc5_);
         }
         UnknownVarFromNameChangeDialog_Sprite_3.addChild(_loc11_);
         _loc11_.x = 50;
         _loc11_.y = 12;
         UnknownVarFromNameChangeDialog_Sprite_1.addChild(UnknownVarFromNameChangeDialog_Sprite_3);
         UnknownVarFromNameChangeDialog_Sprite_3.x = _loc4_;
         _inputDefaultString = _context.getLocalization("name","Click here to type a name");
         UnknownVarFromNameChangeDialog_TextField_1 = LoaderUI.createTextField(_inputDefaultString,14,8947848,true,false,true,false);
         UnknownVarFromNameChangeDialog_Sprite_1.addChild(UnknownVarFromNameChangeDialog_TextField_1);
         UnknownVarFromNameChangeDialog_TextField_1.x = _loc2_.x + 16;
         UnknownVarFromNameChangeDialog_TextField_1.y = _loc2_.y + int((_loc2_.height - UnknownVarFromNameChangeDialog_TextField_1.height) / 2);
         UnknownVarFromNameChangeDialog_TextField_1.width = _loc2_.width - 30;
         UnknownVarFromNameChangeDialog_TextField_1.addEventListener("click",onInputClicked);
         UnknownVarFromNameChangeDialog_TextField_1.addEventListener("change",onInputChange);
         UnknownVarFromNameChangeDialog_WaitIndicator_1 = new WaitIndicator(_style);
         UnknownVarFromNameChangeDialog_Sprite_1.addChild(UnknownVarFromNameChangeDialog_WaitIndicator_1);
         UnknownVarFromNameChangeDialog_WaitIndicator_1.y = _loc2_.y + int(_loc2_.height / 2);
         UnknownVarFromNameChangeDialog_WaitIndicator_1.x = _loc2_.x + _loc2_.width - int(UnknownVarFromNameChangeDialog_Bitmap_1.width / 2) - 15;
         UnknownVarFromNameChangeDialog_WaitIndicator_1.visible = false;
         _loc2_.addEventListener("click",onInputBackgroundClicked);
         var _loc9_:int = -50;
         LoaderUI.resizeFrame(UnknownVarFromNameChangeDialog_Sprite_1,_dialogWidth,_loc9_);
         UnknownVarFromNameChangeDialog_Sprite_1.y = -(int(_loc9_ / 2));
         _dimmer = new Dimmer();
         _container.addChild(UnknownVarFromNameChangeDialog_Sprite_1);
      }
      
      private function onIdleTimer(param1:TimerEvent) : void
      {
         checkName(UnknownVarFromNameChangeDialog_TextField_1.text);
      }
      
      public function setNameClaimed(param1:Boolean) : void
      {
         UnknownVarFromNameChangeDialog_Boolean_1 = param1;
      }
      
      protected function onInputChange(param1:Event) : void
      {
         if(UnknownVarFromNameChangeDialog_Timer_1 != null)
         {
            UnknownVarFromNameChangeDialog_Timer_1.reset();
            UnknownVarFromNameChangeDialog_Timer_1.start();
         }
         removeIndicators();
      }
      
      protected function onInputBackgroundClicked(param1:MouseEvent) : void
      {
         _context.stage.focus = UnknownVarFromNameChangeDialog_TextField_1;
         onInputClicked(null);
      }
      
      protected function onInputClicked(param1:Event) : void
      {
         if(_inputClickedAlready)
         {
            return;
         }
         _inputClickedAlready = true;
         UnknownVarFromNameChangeDialog_TextField_1.text = "";
         UnknownVarFromNameChangeDialog_TextField_1.textColor = _style == 2 ? 6710886 : 0;
         UnknownVarFromNameChangeDialog_TextField_1.removeEventListener("click",onInputClicked);
         onInputChange(null);
      }
      
      public function submitName() : void
      {
         claimName(UnknownVarFromNameChangeDialog_TextField_1.text);
      }
      
      private function get nameChanged() : Boolean
      {
         return UnknownVarFromNameChangeDialog_TextField_1 != null && UnknownVarFromNameChangeDialog_TextField_1.text != _context.getLocalization("name",_inputDefaultString);
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _context.communicationManager.removeHabboConnectionMessageEvent(UnknownVarFromNameChangeDialog_IMessageEvent_1);
         _context.communicationManager.removeHabboConnectionMessageEvent(UnknownVarFromNameChangeDialog_IMessageEvent_2);
         if(_dimmer)
         {
            _container.removeChild(_dimmer);
         }
         if(UnknownVarFromNameChangeDialog_Sprite_1)
         {
            _container.removeChild(UnknownVarFromNameChangeDialog_Sprite_1);
         }
         if(UnknownVarFromNameChangeDialog_WaitIndicator_1 != null)
         {
            UnknownVarFromNameChangeDialog_WaitIndicator_1.dispose();
            UnknownVarFromNameChangeDialog_WaitIndicator_1 = null;
         }
         _dimmer = null;
         UnknownVarFromNameChangeDialog_TextField_1 = null;
         _submitButton = null;
         _skipButton = null;
         UnknownVarFromNameChangeDialog_Sprite_2 = null;
         UnknownVarFromNameChangeDialog_Bitmap_1 = null;
         UnknownVarFromNameChangeDialog_Bitmap_3 = null;
         UnknownVarFromNameChangeDialog_Sprite_1 = null;
         _context = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function claimNameResponse(param1:int, param2:Object, param3:Array) : void
      {
         nameIsCorrect = false;
         switch(param1)
         {
            case ChangeUserNameResultMessageEvent.UnknownVarFromChangeUserNameResultMessageEvent_Int_1:
               nameIsCorrect = true;
               _context.nameChangeCompleted();
               _context.editorFinished();
               break;
            case ChangeUserNameResultMessageEvent.UnknownVarFromChangeUserNameResultMessageEvent_Int_4:
               showErrorMessage(_context.getLocalization("rename.error.too_long","OOPS! YOUR NAME\'S TOO LONG TO REMEMBER"));
               break;
            case ChangeUserNameResultMessageEvent.UnknownVarFromChangeUserNameResultMessageEvent_Int_3:
               showErrorMessage(_context.getLocalization("rename.error.too_short","OOPS! YOUR NAME\'S TOO SHORT TO PRONOUNCE."));
               break;
            case ChangeUserNameResultMessageEvent.UnknownVarFromChangeUserNameResultMessageEvent_Int_5:
               showErrorMessage(_context.getLocalization("rename.error.words","OOPS! THINK HARDER - THAT\'S NOT A VERY NICE NAME."));
               break;
            case ChangeUserNameResultMessageEvent.UnknownVarFromChangeUserNameResultMessageEvent_Int_6:
            case ChangeUserNameResultMessageEvent.UnknownVarFromChangeUserNameResultMessageEvent_Int_7:
               showErrorMessage(_context.getLocalization("rename.error.taken","OOPS! SOMEONE\'S ALREADY USING THAT NAME."));
         }
      }
      
      public function claimNameFailed(param1:String) : void
      {
      }
      
      private function claimName(param1:String) : void
      {
         if(UnknownVarFromNameChangeDialog_Boolean_1)
         {
            _context.nameChangeCompleted();
         }
         _context.communicationManager.connection.send(new ChangeUserNameMessageComposer(param1));
         _context.nameChangeCompleted();
      }
      
      public function checkNameResponse(param1:int, param2:String, param3:Array) : void
      {
         if(UnknownVarFromNameChangeDialog_TextField_1 == null || UnknownVarFromNameChangeDialog_TextField_1.text != param2)
         {
            return;
         }
         if(UnknownVarFromNameChangeDialog_WaitIndicator_1 != null)
         {
            UnknownVarFromNameChangeDialog_WaitIndicator_1.visible = false;
         }
         nameIsCorrect = false;
         switch(param1)
         {
            case ChangeUserNameResultMessageEvent.UnknownVarFromChangeUserNameResultMessageEvent_Int_1:
               nameIsCorrect = true;
               break;
            case ChangeUserNameResultMessageEvent.UnknownVarFromChangeUserNameResultMessageEvent_Int_4:
               showErrorMessage(_context.getLocalization("rename.error.too_long","OOPS! YOUR NAME\'S TOO LONG TO REMEMBER"));
               break;
            case ChangeUserNameResultMessageEvent.UnknownVarFromChangeUserNameResultMessageEvent_Int_3:
               showErrorMessage(_context.getLocalization("rename.error.too_short","OOPS! YOUR NAME\'S TOO SHORT TO PRONOUNCE."));
               break;
            case ChangeUserNameResultMessageEvent.UnknownVarFromChangeUserNameResultMessageEvent_Int_5:
               showErrorMessage(_context.getLocalization("rename.error.words","OOPS! THINK HARDER - THAT\'S NOT A VERY NICE NAME."));
               break;
            case ChangeUserNameResultMessageEvent.UnknownVarFromChangeUserNameResultMessageEvent_Int_6:
            case ChangeUserNameResultMessageEvent.UnknownVarFromChangeUserNameResultMessageEvent_Int_7:
               showErrorMessage(_context.getLocalization("rename.error.taken","OOPS! SOMEONE\'S ALREADY USING THAT NAME."));
         }
         if(UnknownVarFromNameChangeDialog_Sprite_3 != null)
         {
            UnknownVarFromNameChangeDialog_Sprite_3.visible = !nameIsCorrect;
            _context.showHideButtons(nameIsCorrect);
         }
      }
      
      public function checkNameFailed(param1:String) : void
      {
      }
      
      private function checkName(param1:String) : void
      {
         if(!param1 || param1.length == 0)
         {
            return;
         }
         _context.communicationManager.connection.send(new CheckUserNameMessageComposer(param1));
         if(UnknownVarFromNameChangeDialog_WaitIndicator_1 != null)
         {
            UnknownVarFromNameChangeDialog_WaitIndicator_1.visible = true;
         }
      }
      
      protected function get nameIsCorrect() : Boolean
      {
         return UnknownVarFromNameChangeDialog_Bitmap_1 != null && UnknownVarFromNameChangeDialog_Bitmap_1.visible;
      }
      
      protected function set nameIsCorrect(param1:Boolean) : void
      {
         param1 = true;
         if(UnknownVarFromNameChangeDialog_Bitmap_1 != null)
         {
            UnknownVarFromNameChangeDialog_Bitmap_1.visible = param1;
         }
         if(UnknownVarFromNameChangeDialog_Bitmap_2 != null)
         {
            UnknownVarFromNameChangeDialog_Bitmap_2.visible = !param1;
         }
         if(_submitButton != null)
         {
            _submitButton.active = true;
            if(_style == 2)
            {
               _submitButton.visible = true;
               _submitButton.active = nameChanged ? param1 : true;
            }
            else
            {
               _submitButton.visible = param1 && nameChanged;
            }
         }
         if(_skipButton != null)
         {
            if(_style == 2)
            {
               _skipButton.visible = nameChanged;
            }
         }
      }
      
      private function showErrorMessage(param1:String) : void
      {
         var _loc5_:TextField = null;
         var _loc4_:Bitmap = null;
         var _loc2_:Shape = null;
         var _loc3_:int = UnknownVarFromNameChangeDialog_Bitmap_3.width;
         var _loc6_:int = UnknownVarFromNameChangeDialog_Bitmap_3.height;
         UnknownVarFromNameChangeDialog_Bitmap_3.bitmapData = _style == 2 ? NineSplitSprite.INPUT_ERROR_HITCH.render(_loc3_,_loc6_).bitmapData : NineSplitSprite.INPUT_ERROR.render(_loc3_,_loc6_).bitmapData;
         removeIndicators();
         if(UnknownVarFromNameChangeDialog_Bitmap_2 != null)
         {
            UnknownVarFromNameChangeDialog_Bitmap_2.visible = true;
         }
         if(_style == 1)
         {
            _loc5_ = LoaderUI.createTextField(param1,9,16777215,true);
            _loc4_ = LoaderUI.createBalloon(_loc5_.width + 30,_loc5_.height + 17,-1,true,11411485);
            UnknownVarFromNameChangeDialog_Sprite_2 = new Sprite();
            UnknownVarFromNameChangeDialog_Sprite_2.addChild(_loc4_);
            UnknownVarFromNameChangeDialog_Sprite_2.addChild(_loc5_);
            _loc5_.x = 15;
            _loc5_.y = 14;
         }
         else
         {
            _loc5_ = LoaderUI.createTextField(param1,10,16777215);
            _loc2_ = LoaderUI.createScale9GridShapeFromImage(Bitmap(new input_error_alert_hitch_png()).bitmapData,new Rectangle(3,3,5,5));
            _loc3_ = UnknownVarFromNameChangeDialog_Bitmap_3.width;
            if(_loc5_.width > _loc3_)
            {
               _loc3_ = _loc5_.width + 20;
            }
            _loc2_.width = _loc3_;
            _loc2_.height = UnknownVarFromNameChangeDialog_Bitmap_3.height - 11;
            UnknownVarFromNameChangeDialog_Sprite_2 = new Sprite();
            UnknownVarFromNameChangeDialog_Sprite_2.addChild(_loc2_);
            UnknownVarFromNameChangeDialog_Sprite_2.addChild(_loc5_);
            _loc5_.x = 16;
            _loc5_.y = int((_loc2_.height - _loc5_.height) / 2);
         }
         UnknownVarFromNameChangeDialog_Sprite_1.addChild(UnknownVarFromNameChangeDialog_Sprite_2);
         if(_style == 1)
         {
            UnknownVarFromNameChangeDialog_Sprite_2.x = int((UnknownVarFromNameChangeDialog_Sprite_1.width - UnknownVarFromNameChangeDialog_Sprite_2.width) / 2);
            UnknownVarFromNameChangeDialog_Sprite_2.y = UnknownVarFromNameChangeDialog_Bitmap_3.parent.y + UnknownVarFromNameChangeDialog_Bitmap_3.height;
            UnknownVarFromNameChangeDialog_Sprite_2.filters = [new GlowFilter(0,0.24,6,6)];
         }
         else
         {
            UnknownVarFromNameChangeDialog_Sprite_2.x = UnknownVarFromNameChangeDialog_Bitmap_3.parent.x;
            UnknownVarFromNameChangeDialog_Sprite_2.y = UnknownVarFromNameChangeDialog_Bitmap_3.parent.y + UnknownVarFromNameChangeDialog_Bitmap_3.height + 4;
         }
      }
      
      private function removeIndicators() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(UnknownVarFromNameChangeDialog_Sprite_2 != null && UnknownVarFromNameChangeDialog_Sprite_1.contains(UnknownVarFromNameChangeDialog_Sprite_2))
         {
            _loc1_ = UnknownVarFromNameChangeDialog_Bitmap_3.width;
            _loc2_ = UnknownVarFromNameChangeDialog_Bitmap_3.height;
            UnknownVarFromNameChangeDialog_Bitmap_3.bitmapData = _style == 2 ? NineSplitSprite.INPUT_CORRECTED_HITCH.render(_loc1_,_loc2_).bitmapData : NineSplitSprite.INPUT_CORRECTED.render(_loc1_,_loc2_).bitmapData;
            UnknownVarFromNameChangeDialog_Sprite_1.removeChild(UnknownVarFromNameChangeDialog_Sprite_2);
         }
         UnknownVarFromNameChangeDialog_Bitmap_1.visible = false;
         if(UnknownVarFromNameChangeDialog_Bitmap_2 != null)
         {
            UnknownVarFromNameChangeDialog_Bitmap_2.visible = false;
         }
      }
      
      public function set preSelectedGender(param1:String) : void
      {
         UnknownVarFromNameChangeDialog_String_1 = param1;
      }
   }
}

