package com.sulake.habbo.game.snowwar.ui
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.avatar.IAvatarImage_2;
   import com.sulake.habbo.avatar.UnknownIHabboAvatar1;
   import com.sulake.habbo.communication.messages.outgoing.game.arena.Game2ExitGameMessageComposer;
   import com.sulake.habbo.game.snowwar.SnowWarEngine;
   import com.sulake.habbo.game.snowwar.utils.SnowWarAnimatedWindowElement;
   import com.sulake.habbo.game.snowwar.utils.WindowUtils;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   
   public class SnowWarUI implements IComponentInterfaceQueue, UnknownIHabboAvatar1
   {
      private static const EMPTY_AMMO_FLASH_FRAMES:int = 4;
      
      private static const EMPTY_AMMO_FRAME_LENGTH:int = 75;
      
      private static const SCORE_FLASH_FRAMES:int = 4;
      
      private static const SCORE_FRAME_LENGTH:int = 50;
      
      private static const MAX_SNOWBALLS:int = 5;
      
      private static const MAX_ENERGY:int = 5;
      
      private var UnknownVarFromSnowWarUI_SnowWarEngine_1:SnowWarEngine;
      
      private var _exit:IWindowController_1;
      
      private var _snowballs:IWindowController_1;
      
      private var UnknownVarFromSnowWarUI_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromSnowWarUI_IWindowController_1_2:IWindowController_1;
      
      private var _teamScores:IWindowController_1;
      
      private var UnknownVarFromSnowWarUI_IWindowController_1_3:IWindowController_1;
      
      private var _checksumIndicatorColor:RGBColor;
      
      private var _tweenColor:RGBColor;
      
      private var UnknownVarFromSnowWarUI_IBitmapWrapperController_1:IBitmapWrapperController;
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromSnowWarUI_Int_1:int = 1;
      
      private var _timeSinceLastUpdate:uint;
      
      private var UnknownVarFromSnowWarUI_Int_2:int = -1;
      
      private var UnknownVarFromSnowWarUI_Int_3:int = 5;
      
      private var UnknownVarFromSnowWarUI_IBitmapWrapperController_2:IBitmapWrapperController;
      
      private var _makingSnowballs:Boolean = false;
      
      private var UnknownVarFromSnowWarUI_Int_4:int = 5;
      
      private var UnknownVarFromSnowWarUI_IBitmapWrapperController_3:IBitmapWrapperController;
      
      private var UnknownVarFromSnowWarUI_SnowWarAnimatedWindowElement_1:SnowWarAnimatedWindowElement;
      
      private var _emptyAmmoFlash:IBitmapWrapperController;
      
      private var _emptyAmmoAnimation:SnowWarAnimatedWindowElement;
      
      private var UnknownVarFromSnowWarUI_IBitmapWrapperController_4:IBitmapWrapperController;
      
      private var UnknownVarFromSnowWarUI_Int_5:int = 0;
      
      private var UnknownVarFromSnowWarUI_String_1:String = "";
      
      private var UnknownVarFromSnowWarUI_Timer_1:Timer;
      
      private var UnknownVarFromSnowWarUI_Boolean_1:Boolean;
      
      public function SnowWarUI(param1:SnowWarEngine)
      {
         super();
         UnknownVarFromSnowWarUI_SnowWarEngine_1 = param1;
         UnknownVarFromSnowWarUI_SnowWarEngine_1.windowManager.getDesktop(1).visible = false;
         UnknownVarFromSnowWarUI_Boolean_1 = UnknownVarFromSnowWarUI_SnowWarEngine_1.sessionDataManager.hasSecurity(4);
         if(UnknownVarFromSnowWarUI_Boolean_1)
         {
            _checksumIndicatorColor = new RGBColor();
            _tweenColor = new RGBColor(16777215);
         }
      }
      
      public function dispose() : void
      {
         UnknownVarFromSnowWarUI_SnowWarEngine_1.windowManager.getDesktop(1).visible = true;
         UnknownVarFromSnowWarUI_SnowWarEngine_1 = null;
         if(_exit)
         {
            _exit.dispose();
            _exit = null;
         }
         if(_snowballs)
         {
            UnknownVarFromSnowWarUI_IBitmapWrapperController_2 = null;
            UnknownVarFromSnowWarUI_IBitmapWrapperController_3 = null;
            _emptyAmmoFlash = null;
            _snowballs.dispose();
            _snowballs = null;
         }
         if(UnknownVarFromSnowWarUI_IWindowController_1_1)
         {
            UnknownVarFromSnowWarUI_IBitmapWrapperController_4 = null;
            UnknownVarFromSnowWarUI_IWindowController_1_1.dispose();
            UnknownVarFromSnowWarUI_IWindowController_1_1 = null;
         }
         if(UnknownVarFromSnowWarUI_IWindowController_1_2)
         {
            UnknownVarFromSnowWarUI_IWindowController_1_2.dispose();
            UnknownVarFromSnowWarUI_IWindowController_1_2 = null;
         }
         if(_teamScores)
         {
            _teamScores.dispose();
            _teamScores = null;
         }
         if(UnknownVarFromSnowWarUI_IBitmapWrapperController_1)
         {
            UnknownVarFromSnowWarUI_IBitmapWrapperController_1.dispose();
            UnknownVarFromSnowWarUI_IBitmapWrapperController_1 = null;
         }
         if(_emptyAmmoAnimation != null)
         {
            _emptyAmmoAnimation.dispose();
            _emptyAmmoAnimation = null;
         }
         if(UnknownVarFromSnowWarUI_IWindowController_1_3)
         {
            UnknownVarFromSnowWarUI_IWindowController_1_3.dispose();
            UnknownVarFromSnowWarUI_IWindowController_1_3 = null;
         }
         if(UnknownVarFromSnowWarUI_Timer_1)
         {
            UnknownVarFromSnowWarUI_Timer_1.removeEventListener("timerComplete",onTimerHider);
            UnknownVarFromSnowWarUI_Timer_1.stop();
            UnknownVarFromSnowWarUI_Timer_1 = null;
         }
         disposeLoadIcon();
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function init() : void
      {
         _exit = WindowUtils.createWindow("snowwar_exit") as IWindowController_1;
         _exit.addEventListener("WME_CLICK",onExit);
         _exit.x = 0;
         _exit.y = 10;
         _snowballs = WindowUtils.createWindow("snowwar_snowballs") as IWindowController_1;
         var _loc1_:IWindowModel = _snowballs.findChildByName("make_snowball");
         _loc1_.addEventListener("WME_DOWN",onMakeSnowballDown);
         _loc1_.addEventListener("WME_UP",onMakeSnowballUp);
         _loc1_.addEventListener("WME_OUT",onMakeSnowballUp);
         _snowballs.center();
         _snowballs.x = 10;
         UnknownVarFromSnowWarUI_IBitmapWrapperController_2 = _snowballs.findChildByName("makeSnowballImage") as IBitmapWrapperController;
         _emptyAmmoFlash = _snowballs.findChildByName("emptyFlashImage") as IBitmapWrapperController;
         _emptyAmmoFlash.visible = false;
         _emptyAmmoAnimation = new SnowWarAnimatedWindowElement(UnknownVarFromSnowWarUI_SnowWarEngine_1.assets,_emptyAmmoFlash,"ui_no_balls_",4,75,true);
         UnknownVarFromSnowWarUI_IBitmapWrapperController_3 = _snowballs.findChildByName("ballProgress") as IBitmapWrapperController;
         UnknownVarFromSnowWarUI_IWindowController_1_1 = WindowUtils.createWindow("snowwar_own_stats") as IWindowController_1;
         UnknownVarFromSnowWarUI_IWindowController_1_1.x = 10;
         UnknownVarFromSnowWarUI_IWindowController_1_1.y = UnknownVarFromSnowWarUI_IWindowController_1_1.desktop.height - UnknownVarFromSnowWarUI_IWindowController_1_1.height - 10;
         UnknownVarFromSnowWarUI_IBitmapWrapperController_4 = UnknownVarFromSnowWarUI_IWindowController_1_1.findChildByName("backgroundFlashImage") as IBitmapWrapperController;
         updateUserImage();
         _teamScores = WindowUtils.createWindow("snowwar_team_scores") as IWindowController_1;
         _teamScores.x = _teamScores.desktop.width - _teamScores.width - 10;
         _teamScores.y = 10;
         UnknownVarFromSnowWarUI_IWindowController_1_2 = WindowUtils.createWindow("snowwar_timer") as IWindowController_1;
         UnknownVarFromSnowWarUI_IWindowController_1_2.x = UnknownVarFromSnowWarUI_IWindowController_1_2.desktop.width - UnknownVarFromSnowWarUI_IWindowController_1_2.width - 50;
         UnknownVarFromSnowWarUI_IWindowController_1_2.y = 105;
         timer = 0;
         UnknownVarFromSnowWarUI_IBitmapWrapperController_1 = WindowUtils.createWindow("counter") as IBitmapWrapperController;
         UnknownVarFromSnowWarUI_IBitmapWrapperController_1.center();
         if(UnknownVarFromSnowWarUI_Boolean_1)
         {
            UnknownVarFromSnowWarUI_IWindowController_1_2.getChildByName("checksumIndicator").visible = true;
            _checksumIndicatorColor.fromInt(UnknownVarFromSnowWarUI_IWindowController_1_2.color);
         }
         UnknownVarFromSnowWarUI_Int_3 = 5;
      }
      
      public function avatarImageReady(param1:String) : void
      {
         updateUserImage();
      }
      
      private function updateUserImage() : void
      {
         var _loc1_:BitmapData = null;
         var _loc3_:String = UnknownVarFromSnowWarUI_SnowWarEngine_1.sessionDataManager.figure;
         var _loc2_:String = UnknownVarFromSnowWarUI_SnowWarEngine_1.sessionDataManager.gender;
         var _loc4_:IAvatarImage_2 = UnknownVarFromSnowWarUI_SnowWarEngine_1.avatarManager.createAvatarImage(_loc3_,"h",_loc2_,this);
         if(_loc4_ != null)
         {
            _loc4_.setDirection("full",2);
            _loc1_ = _loc4_.getCroppedImage("head");
            _loc4_.dispose();
            WindowUtils.setElementImage(UnknownVarFromSnowWarUI_IWindowController_1_1.findChildByName("user_image"),_loc1_);
            _loc1_.dispose();
         }
      }
      
      private function getBitmap(param1:String) : BitmapData
      {
         return UnknownVarFromSnowWarUI_SnowWarEngine_1.assets.getAssetByName(param1).content as BitmapData;
      }
      
      private function getElement(param1:IWindowController_1, param2:String) : IWindowModel
      {
         return param1.findChildByName(param2);
      }
      
      private function onMakeSnowballDown(param1:WindowMouseEvent) : void
      {
         makeSnowballButtonPressed(true);
         if(UnknownVarFromSnowWarUI_SnowWarEngine_1.makeSnowball())
         {
            startWaitingForSnowball();
         }
      }
      
      private function onMakeSnowballUp(param1:WindowMouseEvent) : void
      {
         makeSnowballButtonPressed(false);
      }
      
      public function startWaitingForSnowball() : void
      {
         if(UnknownVarFromSnowWarUI_SnowWarAnimatedWindowElement_1 != null)
         {
            UnknownVarFromSnowWarUI_SnowWarAnimatedWindowElement_1.dispose();
            UnknownVarFromSnowWarUI_SnowWarAnimatedWindowElement_1 = null;
         }
         UnknownVarFromSnowWarUI_SnowWarAnimatedWindowElement_1 = new SnowWarAnimatedWindowElement(UnknownVarFromSnowWarUI_SnowWarEngine_1.assets,UnknownVarFromSnowWarUI_IBitmapWrapperController_3,"load_",8);
         SnowWarEngine.playSound("HBSTG_snowwar_make_snowball");
      }
      
      public function stopWaitingForSnowball() : void
      {
         disposeLoadIcon();
         SnowWarEngine.stopSound("HBSTG_snowwar_make_snowball");
         if(_makingSnowballs)
         {
            onMakeSnowballDown(null);
         }
      }
      
      private function disposeLoadIcon() : void
      {
         if(UnknownVarFromSnowWarUI_SnowWarAnimatedWindowElement_1 != null)
         {
            UnknownVarFromSnowWarUI_SnowWarAnimatedWindowElement_1.dispose();
            UnknownVarFromSnowWarUI_SnowWarAnimatedWindowElement_1 = null;
         }
      }
      
      private function onExit(param1:WindowMouseEvent) : void
      {
         if(!UnknownVarFromSnowWarUI_IWindowController_1_3)
         {
            UnknownVarFromSnowWarUI_IWindowController_1_3 = WindowUtils.createWindow("snowwar_exit_confirmation") as IWindowController_1;
            UnknownVarFromSnowWarUI_IWindowController_1_3.findChildByName("yes").addEventListener("WME_CLICK",confirmationHandler);
            UnknownVarFromSnowWarUI_IWindowController_1_3.findChildByName("no").addEventListener("WME_CLICK",confirmationHandler);
            UnknownVarFromSnowWarUI_IWindowController_1_3.findChildByTag("close").addEventListener("WME_CLICK",confirmationHandler);
         }
         else
         {
            UnknownVarFromSnowWarUI_IWindowController_1_3.visible = true;
            UnknownVarFromSnowWarUI_IWindowController_1_3.activate();
         }
      }
      
      private function confirmationHandler(param1:WindowMouseEvent) : void
      {
         if(param1.window.name == "yes")
         {
            UnknownVarFromSnowWarUI_SnowWarEngine_1.send(new Game2ExitGameMessageComposer());
            UnknownVarFromSnowWarUI_SnowWarEngine_1.resetGameSession();
            UnknownVarFromSnowWarUI_SnowWarEngine_1.resetRoomSession();
         }
         else
         {
            UnknownVarFromSnowWarUI_IWindowController_1_3.visible = false;
         }
      }
      
      public function set snowballs(param1:int) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            _snowballs.findChildByName("ball_" + _loc3_).visible = _loc3_ < param1;
            _loc3_++;
         }
         UnknownVarFromSnowWarUI_Int_4 = param1;
         var _loc2_:IWindowModel = _snowballs.findChildByName("ball_" + param1);
         if(_loc2_ != null)
         {
            UnknownVarFromSnowWarUI_IBitmapWrapperController_3.x = _loc2_.x;
            UnknownVarFromSnowWarUI_IBitmapWrapperController_3.y = _loc2_.y;
         }
      }
      
      public function set ownScore(param1:int) : void
      {
         WindowUtils.setCaption(UnknownVarFromSnowWarUI_IWindowController_1_1.findChildByName("personal_score"),param1.toString());
      }
      
      public function set timer(param1:int) : void
      {
         if(UnknownVarFromSnowWarUI_Boolean_1)
         {
            if(_checksumIndicatorColor)
            {
               _checksumIndicatorColor.tweenTo(_tweenColor);
               UnknownVarFromSnowWarUI_IWindowController_1_2.getChildByName("checksumIndicator").color = _checksumIndicatorColor.rgb;
            }
         }
         if(UnknownVarFromSnowWarUI_Int_2 == param1)
         {
            return;
         }
         UnknownVarFromSnowWarUI_Int_2 = param1;
         var _loc2_:String = "" + int(param1 / 60);
         var _loc3_:String = "" + int(param1 % 60);
         if(int(_loc2_) < 10)
         {
            _loc2_ = "0" + _loc2_;
         }
         if(int(_loc3_) < 10)
         {
            _loc3_ = "0" + _loc3_;
         }
         WindowUtils.showElement(UnknownVarFromSnowWarUI_IWindowController_1_2,"time_left");
         WindowUtils.setCaption(UnknownVarFromSnowWarUI_IWindowController_1_2.findChildByName("time_left"),_loc2_ + ":" + _loc3_);
         if(param1 <= 5 && param1 > 0)
         {
            SnowWarEngine.playSound("HBST_call_for_help");
            if(!UnknownVarFromSnowWarUI_Timer_1)
            {
               UnknownVarFromSnowWarUI_Timer_1 = new Timer(500,1);
               UnknownVarFromSnowWarUI_Timer_1.addEventListener("timerComplete",onTimerHider);
            }
            UnknownVarFromSnowWarUI_Timer_1.reset();
            UnknownVarFromSnowWarUI_Timer_1.start();
         }
      }
      
      private function onTimerHider(param1:TimerEvent) : void
      {
         if(UnknownVarFromSnowWarUI_IWindowController_1_2)
         {
            WindowUtils.hideElement(UnknownVarFromSnowWarUI_IWindowController_1_2,"time_left");
         }
      }
      
      public function set hitPoints(param1:int) : void
      {
         if(UnknownVarFromSnowWarUI_Int_3 != param1)
         {
            WindowUtils.setElementImage(getElement(UnknownVarFromSnowWarUI_IWindowController_1_1,"energy_bar"),getBitmap("ui_me_health_" + Math.min(5,param1)));
            UnknownVarFromSnowWarUI_Int_3 = param1;
         }
      }
      
      public function showChecksumError(param1:uint) : void
      {
         if(UnknownVarFromSnowWarUI_Boolean_1)
         {
            UnknownVarFromSnowWarUI_IWindowController_1_2.color = param1;
            if(_checksumIndicatorColor)
            {
               _checksumIndicatorColor.fromInt(param1);
            }
         }
      }
      
      public function initCounter() : void
      {
         _timeSinceLastUpdate = 0;
         UnknownVarFromSnowWarUI_Int_1 = 1;
      }
      
      public function update(param1:uint) : void
      {
         updateAmmoDisplay();
         updateCounterImage(param1);
         updateScoreFlash(param1);
         updateTeamScores();
      }
      
      private function updateScoreFlash(param1:uint) : void
      {
         var _loc2_:int = 0;
         if(UnknownVarFromSnowWarUI_Int_5 > 0)
         {
            _loc2_ = UnknownVarFromSnowWarUI_Int_5 / 50 + 1;
            if(_loc2_ > 4)
            {
               UnknownVarFromSnowWarUI_Int_5 = 0;
               UnknownVarFromSnowWarUI_IBitmapWrapperController_4.visible = false;
            }
            else
            {
               UnknownVarFromSnowWarUI_Int_5 += param1;
               UnknownVarFromSnowWarUI_IBitmapWrapperController_4.visible = true;
               WindowUtils.setElementImage(UnknownVarFromSnowWarUI_IBitmapWrapperController_4,getBitmap(UnknownVarFromSnowWarUI_String_1 + _loc2_));
            }
         }
      }
      
      public function flashOwnScore(param1:Boolean) : void
      {
         UnknownVarFromSnowWarUI_Int_5 = 1;
         UnknownVarFromSnowWarUI_String_1 = param1 ? "ui_me_plus_" : "ui_me_minus_";
      }
      
      private function updateAmmoDisplay() : void
      {
         _emptyAmmoFlash.visible = UnknownVarFromSnowWarUI_Int_4 == 0 && UnknownVarFromSnowWarUI_SnowWarAnimatedWindowElement_1 == null;
      }
      
      private function updateCounterImage(param1:uint) : void
      {
         var _loc2_:BitmapData = null;
         var _loc3_:Point = null;
         var _loc5_:Boolean = false;
         _timeSinceLastUpdate += param1;
         if(UnknownVarFromSnowWarUI_Int_1 < 6)
         {
            if(_timeSinceLastUpdate >= 1000)
            {
               _loc5_ = true;
               _timeSinceLastUpdate = 0;
            }
         }
         else if(UnknownVarFromSnowWarUI_Int_1 < 11)
         {
            if(_timeSinceLastUpdate > 100)
            {
               _loc5_ = true;
               _timeSinceLastUpdate = 0;
            }
         }
         else if(UnknownVarFromSnowWarUI_IBitmapWrapperController_1)
         {
            UnknownVarFromSnowWarUI_IBitmapWrapperController_1.dispose();
            UnknownVarFromSnowWarUI_IBitmapWrapperController_1 = null;
         }
         if(!_loc5_ || _disposed || !UnknownVarFromSnowWarUI_IBitmapWrapperController_1)
         {
            return;
         }
         var _loc4_:BitmapDataAsset = UnknownVarFromSnowWarUI_SnowWarEngine_1.assets.getAssetByName(padName("explosion",UnknownVarFromSnowWarUI_Int_1)) as BitmapDataAsset;
         if(_loc4_)
         {
            _loc2_ = _loc4_.content as BitmapData;
            if(!UnknownVarFromSnowWarUI_IBitmapWrapperController_1.bitmap)
            {
               UnknownVarFromSnowWarUI_IBitmapWrapperController_1.bitmap = new BitmapData(UnknownVarFromSnowWarUI_IBitmapWrapperController_1.width,UnknownVarFromSnowWarUI_IBitmapWrapperController_1.height,true,16777215);
            }
            UnknownVarFromSnowWarUI_IBitmapWrapperController_1.bitmap.fillRect(UnknownVarFromSnowWarUI_IBitmapWrapperController_1.bitmap.rect,16777215);
            _loc3_ = new Point(-_loc4_.offset.x,-_loc4_.offset.y);
            UnknownVarFromSnowWarUI_IBitmapWrapperController_1.bitmap.copyPixels(_loc2_,_loc2_.rect,_loc3_,null,null,true);
            UnknownVarFromSnowWarUI_IBitmapWrapperController_1.invalidate();
         }
         UnknownVarFromSnowWarUI_Int_1++;
      }
      
      private function padName(param1:String, param2:int, param3:int = 4) : String
      {
         var _loc4_:String = param2.toString();
         while(_loc4_.length < param3)
         {
            _loc4_ = "0" + _loc4_;
         }
         return param1 + _loc4_;
      }
      
      private function updateTeamScores() : void
      {
         var _loc1_:Array = UnknownVarFromSnowWarUI_SnowWarEngine_1.gameArena.getTeamScores();
         if(_loc1_.length >= 2)
         {
            WindowUtils.setCaption(_teamScores.findChildByName("score_blue"),_loc1_[0]);
            WindowUtils.setCaption(_teamScores.findChildByName("score_red"),_loc1_[1]);
         }
      }
      
      private function makeSnowballButtonPressed(param1:Boolean) : void
      {
         if(_makingSnowballs != param1)
         {
            WindowUtils.setElementImage(UnknownVarFromSnowWarUI_IBitmapWrapperController_2,getBitmap("ui_make_balls_" + (param1 ? "down" : "up")));
         }
         _makingSnowballs = param1;
      }
   }
}

class RGBColor
{
   private var _r:uint;
   
   private var _g:uint;
   
   private var _b:uint;
   
   private var _a:uint;
   
   public function RGBColor(param1:uint = 0)
   {
      super();
      fromInt(param1);
   }
   
   public function get r() : uint
   {
      return _r;
   }
   
   public function get g() : uint
   {
      return _g;
   }
   
   public function get b() : uint
   {
      return _b;
   }
   
   public function get a() : uint
   {
      return _a;
   }
   
   public function fromInt(param1:uint) : void
   {
      _a = param1 >> 24 & 0xFF;
      _r = param1 >> 16 & 0xFF;
      _g = param1 >> 8 & 0xFF;
      _b = param1 >> 0 & 0xFF;
   }
   
   public function get rgb() : uint
   {
      return _a << 24 | _r << 16 | _g << 8 | _b;
   }
   
   public function tweenTo(param1:RGBColor) : void
   {
      _a += (param1.a - a) / 24;
      _r += (param1.r - r) / 24;
      _g += (param1.g - g) / 24;
      _b += (param1.b - b) / 24;
   }
}
