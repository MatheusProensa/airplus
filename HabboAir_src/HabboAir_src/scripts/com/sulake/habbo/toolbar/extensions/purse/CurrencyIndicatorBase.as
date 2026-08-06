package com.sulake.habbo.toolbar.extensions.purse
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.utils.UnknownHabboUtils1;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class CurrencyIndicatorBase implements ICurrencyIndicatorBase
   {
      protected static const UnknownConstFromCurrencyIndicatorBase_Int_1:int = 0;
      
      protected static const UnknownConstFromCurrencyIndicatorBase_Int_2:int = 1;
      
      private static const UnknownConstFromCurrencyIndicatorBase_Number_1:Number = 0.025;
      
      protected var _window:IWindowController_1;
      
      protected var _windowManager:IHabboWindowManagerComponent;
      
      protected var _assets:IAssetLibraryCollection;
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromCurrencyIndicatorBase_IStaticBitmapWrapperWindow_1:IStaticBitmapWrapperWindow;
      
      private var UnknownVarFromCurrencyIndicatorBase_Uint_1:uint;
      
      private var UnknownVarFromCurrencyIndicatorBase_Uint_2:uint;
      
      private var _textElementName:String;
      
      private var UnknownVarFromCurrencyIndicatorBase_Vector_1:Vector.<String> = new Vector.<String>();
      
      private var UnknownVarFromCurrencyIndicatorBase_Uint_3:uint;
      
      private var _amountZeroText:String = null;
      
      private var UnknownVarFromCurrencyIndicatorBase_Uint_4:uint = 0;
      
      private var UnknownVarFromCurrencyIndicatorBase_Int_1:int;
      
      private var UnknownVarFromCurrencyIndicatorBase_Timer_1:Timer;
      
      private var _overlayTimer:Timer;
      
      private var _overlayPhase:Number;
      
      private var _overlayStartValue:int;
      
      private var _overlayEndValue:int;
      
      public function CurrencyIndicatorBase(param1:IHabboWindowManagerComponent, param2:IAssetLibraryCollection)
      {
         super();
         _window = null;
         _windowManager = param1;
         _assets = param2;
         UnknownVarFromCurrencyIndicatorBase_Timer_1 = null;
         _overlayTimer = new Timer(40);
         _overlayTimer.addEventListener("timer",onOverlayTimer);
      }
      
      protected function set bgColorLight(param1:uint) : void
      {
         UnknownVarFromCurrencyIndicatorBase_Uint_1 = param1;
      }
      
      protected function set bgColorDark(param1:uint) : void
      {
         UnknownVarFromCurrencyIndicatorBase_Uint_2 = param1;
      }
      
      protected function set textElementName(param1:String) : void
      {
         _textElementName = param1;
      }
      
      protected function set iconAnimationDelay(param1:uint) : void
      {
         UnknownVarFromCurrencyIndicatorBase_Uint_3 = param1;
      }
      
      protected function set amountZeroText(param1:String) : void
      {
         _amountZeroText = param1;
      }
      
      protected function get amountZeroText() : String
      {
         return _amountZeroText;
      }
      
      public function get window() : IWindowController_1
      {
         return _window;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(_overlayTimer != null)
         {
            _overlayTimer.stop();
            _overlayTimer = null;
         }
         if(UnknownVarFromCurrencyIndicatorBase_Timer_1)
         {
            UnknownVarFromCurrencyIndicatorBase_Timer_1.stop();
            UnknownVarFromCurrencyIndicatorBase_Timer_1 = null;
         }
         if(UnknownVarFromCurrencyIndicatorBase_Vector_1)
         {
            UnknownVarFromCurrencyIndicatorBase_Vector_1 = null;
         }
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         _disposed = true;
      }
      
      public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
      }
      
      public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
      }
      
      protected function onContainerClick(param1:WindowMouseEvent) : void
      {
      }
      
      protected function createWindow(param1:String, param2:String) : void
      {
         var _loc4_:Array = null;
         var _loc3_:XmlAsset = _assets.getAssetByName(param1) as XmlAsset;
         if(_loc3_)
         {
            _window = _windowManager.buildFromXML(_loc3_.content as XML,1) as IWindowController_1;
            if(_window)
            {
               _window.addEventListener("WME_CLICK",onContainerClick);
               _window.addEventListener("WME_OVER",onContainerMouseOver);
               _window.addEventListener("WME_OUT",onContainerMouseOut);
               _loc4_ = [];
               if(_window.groupChildrenWithTag("ICON",_loc4_,-1) == 1)
               {
                  UnknownVarFromCurrencyIndicatorBase_IStaticBitmapWrapperWindow_1 = _loc4_[0] as IStaticBitmapWrapperWindow;
                  setIconBitmap(param2);
               }
            }
         }
      }
      
      protected function animateIcon(param1:int) : void
      {
         UnknownVarFromCurrencyIndicatorBase_Uint_4 = param1;
         if(UnknownVarFromCurrencyIndicatorBase_IStaticBitmapWrapperWindow_1 && UnknownVarFromCurrencyIndicatorBase_Vector_1.length > 0)
         {
            if(UnknownVarFromCurrencyIndicatorBase_Uint_4 == 0)
            {
               UnknownVarFromCurrencyIndicatorBase_Int_1 = 0;
            }
            else
            {
               UnknownVarFromCurrencyIndicatorBase_Int_1 = UnknownVarFromCurrencyIndicatorBase_Vector_1.length - 1;
            }
            UnknownVarFromCurrencyIndicatorBase_Timer_1 = new Timer(UnknownVarFromCurrencyIndicatorBase_Uint_3,UnknownVarFromCurrencyIndicatorBase_Vector_1.length);
            UnknownVarFromCurrencyIndicatorBase_Timer_1.addEventListener("timer",onAnimationTimer);
            UnknownVarFromCurrencyIndicatorBase_Timer_1.addEventListener("timerComplete",onAnimationTimerComplete);
            UnknownVarFromCurrencyIndicatorBase_Timer_1.start();
            onAnimationTimer(null);
         }
      }
      
      protected function setAmount(param1:int, param2:int = -1) : void
      {
         setText(param1.toString());
      }
      
      protected function setText(param1:String) : void
      {
         if(_window)
         {
            _window.findChildByName(_textElementName).caption = param1;
         }
      }
      
      protected function setTextUnderline(param1:Boolean) : void
      {
         if(_window)
         {
            ITextWindow(_window.findChildByName(_textElementName)).underline = param1;
         }
      }
      
      protected function set iconAnimationSequence(param1:Array) : void
      {
         var _loc2_:* = null;
         for each(_loc2_ in param1)
         {
            UnknownVarFromCurrencyIndicatorBase_Vector_1.push(_loc2_);
         }
      }
      
      private function onAnimationTimer(param1:TimerEvent) : void
      {
         if(UnknownVarFromCurrencyIndicatorBase_IStaticBitmapWrapperWindow_1 && UnknownVarFromCurrencyIndicatorBase_Vector_1.length > 0)
         {
            setIconBitmap(UnknownVarFromCurrencyIndicatorBase_Vector_1[UnknownVarFromCurrencyIndicatorBase_Int_1]);
            if(UnknownVarFromCurrencyIndicatorBase_Uint_4 == 0)
            {
               UnknownVarFromCurrencyIndicatorBase_Int_1++;
               UnknownVarFromCurrencyIndicatorBase_Int_1 = UnknownVarFromCurrencyIndicatorBase_Int_1 < UnknownVarFromCurrencyIndicatorBase_Vector_1.length ? UnknownVarFromCurrencyIndicatorBase_Int_1 : UnknownVarFromCurrencyIndicatorBase_Vector_1.length - 1;
            }
            else
            {
               UnknownVarFromCurrencyIndicatorBase_Int_1--;
               UnknownVarFromCurrencyIndicatorBase_Int_1 = UnknownVarFromCurrencyIndicatorBase_Int_1 >= 0 ? UnknownVarFromCurrencyIndicatorBase_Int_1 : 0;
            }
         }
      }
      
      private function onAnimationTimerComplete(param1:TimerEvent) : void
      {
         if(UnknownVarFromCurrencyIndicatorBase_Vector_1.length > 0)
         {
            setIconBitmap(UnknownVarFromCurrencyIndicatorBase_Vector_1[0]);
         }
      }
      
      private function setIconBitmap(param1:String) : void
      {
         if(UnknownVarFromCurrencyIndicatorBase_IStaticBitmapWrapperWindow_1)
         {
            UnknownVarFromCurrencyIndicatorBase_IStaticBitmapWrapperWindow_1.assetUri = param1;
         }
      }
      
      private function onContainerMouseOver(param1:WindowMouseEvent) : void
      {
         _window.findChildByTag("BGCOLOR").color = UnknownVarFromCurrencyIndicatorBase_Uint_1;
      }
      
      private function onContainerMouseOut(param1:WindowMouseEvent) : void
      {
         _window.findChildByTag("BGCOLOR").color = UnknownVarFromCurrencyIndicatorBase_Uint_2;
      }
      
      protected function animateChange(param1:int, param2:int) : void
      {
         var _loc3_:IWindowModel = null;
         _overlayPhase = 0;
         _overlayStartValue = param1;
         _overlayEndValue = param2;
         if(_window != null)
         {
            _loc3_ = _window.findChildByName("change");
            if(_loc3_ != null)
            {
               _loc3_.caption = (param2 > param1 ? "+" : "") + (param2 - param1).toString();
            }
         }
         _overlayTimer.start();
         onOverlayTimer(null);
      }
      
      private function onOverlayTimer(param1:TimerEvent) : void
      {
         var _loc3_:Number = Math.pow(_overlayPhase - 0.5,3) * 4 + 0.5;
         setAmount(int(UnknownHabboUtils1.lerp(Math.max(0,_overlayPhase * 2 - 1),_overlayStartValue,_overlayEndValue)));
         var _loc2_:IWindowController_1 = _window.findChildByName("change_overlay") as IWindowController_1;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.visible = true;
         _loc2_.blend = 1 - Math.abs(0.5 - _loc3_) * 2;
         _loc2_.x = UnknownHabboUtils1.lerp(_loc3_,0,_window.width - _loc2_.width);
         _overlayPhase += 0.025;
         if(_overlayPhase >= 1)
         {
            _loc2_.visible = false;
            _overlayTimer.stop();
            setAmount(_overlayEndValue);
         }
      }
   }
}

