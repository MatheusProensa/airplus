package com.sulake.habbo.ui.widget.effects
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.ui.widget.memenu.UnknownIHabboUiWidgetMemenu1;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.utils.Timer;
   
   public class EffectView
   {
      private const UPDATE_TIMER_MS:int = 1000;
      
      private var UnknownVarFromEffectView_EffectsWidget_1:EffectsWidget;
      
      private var _window:IWindowController_1;
      
      private var _effect:UnknownIHabboUiWidgetMemenu1;
      
      private var _bar:IWindowModel;
      
      private var _maxWidth:Number;
      
      private var UnknownVarFromEffectView_ITextWindow_1:ITextWindow;
      
      private var UnknownVarFromEffectView_Timer_1:Timer;
      
      private var _hilite:IWindowModel;
      
      public function EffectView(param1:EffectsWidget, param2:UnknownIHabboUiWidgetMemenu1)
      {
         super();
         _effect = param2;
         UnknownVarFromEffectView_EffectsWidget_1 = param1;
         UnknownVarFromEffectView_Timer_1 = new Timer(1000);
         UnknownVarFromEffectView_Timer_1.addEventListener("timer",onUpdate);
         update();
      }
      
      public function get effect() : UnknownIHabboUiWidgetMemenu1
      {
         return _effect;
      }
      
      public function dispose() : void
      {
         if(UnknownVarFromEffectView_Timer_1 != null)
         {
            UnknownVarFromEffectView_Timer_1.stop();
            UnknownVarFromEffectView_Timer_1.removeEventListener("timer",onUpdate);
            UnknownVarFromEffectView_Timer_1 = null;
         }
         UnknownVarFromEffectView_EffectsWidget_1 = null;
         _effect = null;
         _bar = null;
         UnknownVarFromEffectView_ITextWindow_1 = null;
         _hilite = null;
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function get window() : IWindowController_1
      {
         return _window;
      }
      
      private function onUpdate(param1:Event = null) : void
      {
         var _loc2_:Number = NaN;
         if(_bar == null)
         {
            UnknownVarFromEffectView_Timer_1.stop();
            return;
         }
         if(_effect.isActive)
         {
            _loc2_ = _effect.secondsLeft / _effect.duration;
            _bar.width = _loc2_ * _maxWidth;
         }
         else
         {
            _bar.width = 0;
            UnknownVarFromEffectView_Timer_1.stop();
         }
         setTimeLeft();
      }
      
      private function setTimeLeft() : void
      {
         var _loc8_:String = null;
         var _loc7_:int = 0;
         var _loc9_:int = 0;
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:String = null;
         var _loc4_:String = null;
         var _loc6_:String = null;
         if(UnknownVarFromEffectView_ITextWindow_1 == null)
         {
            UnknownVarFromEffectView_ITextWindow_1 = _window.findChildByName("time_left") as ITextWindow;
            if(UnknownVarFromEffectView_ITextWindow_1 == null)
            {
               return;
            }
         }
         if(!_effect.isActive)
         {
            UnknownVarFromEffectView_ITextWindow_1.caption = "${widgets.memenu.effects.activate}";
            return;
         }
         if(_effect.secondsLeft > 86400)
         {
            UnknownVarFromEffectView_ITextWindow_1.caption = "${widgets.memenu.effects.active.daysleft}";
            _loc8_ = UnknownVarFromEffectView_ITextWindow_1.text;
            _loc7_ = Math.floor(_effect.secondsLeft / 86400);
            _loc8_ = _loc8_.replace("%days_left%",_loc7_);
         }
         else
         {
            UnknownVarFromEffectView_ITextWindow_1.caption = "${widgets.memenu.effects.active.timeleft}";
            _loc8_ = UnknownVarFromEffectView_ITextWindow_1.text;
            _loc9_ = _effect.secondsLeft;
            _loc1_ = Math.floor(_loc9_ / 3600);
            _loc3_ = Math.floor(_loc9_ / 60) % 60;
            _loc2_ = _loc9_ % 60;
            _loc5_ = _loc1_ < 10 ? "0" : "";
            _loc4_ = _loc3_ < 10 ? "0" : "";
            _loc6_ = _loc2_ < 10 ? "0" : "";
            if(_loc1_ > 0)
            {
               _loc8_ = _loc8_.replace("%time_left%",_loc5_ + _loc1_ + ":" + _loc4_ + _loc3_ + ":" + _loc6_ + _loc2_);
            }
            else
            {
               _loc8_ = _loc8_.replace("%time_left%",_loc4_ + _loc3_ + ":" + _loc6_ + _loc2_);
            }
         }
         UnknownVarFromEffectView_ITextWindow_1.text = _loc8_;
      }
      
      public function update() : void
      {
         var _loc7_:IWindowModel = null;
         var _loc5_:XmlAsset = null;
         var _loc4_:UnknownICoreWindowComponents4 = null;
         if(!_window)
         {
            _window = UnknownVarFromEffectView_EffectsWidget_1.windowManager.createWindow("","",4,0,16) as IWindowController_1;
         }
         while(_window.numChildren > 0)
         {
            _loc7_ = _window.removeChildAt(0);
            _loc7_.dispose();
         }
         _bar = null;
         _hilite = null;
         UnknownVarFromEffectView_ITextWindow_1 = null;
         var _loc2_:String = "";
         if(_effect.isInUse)
         {
            _loc2_ = "memenu_effect_selected";
         }
         else if(_effect.isActive)
         {
            _loc2_ = "memenu_effect_unselected";
         }
         else
         {
            _loc2_ = "memenu_effect_inactive";
         }
         _loc5_ = UnknownVarFromEffectView_EffectsWidget_1.assets.getAssetByName(_loc2_) as XmlAsset;
         var _loc6_:IWindowController_1 = UnknownVarFromEffectView_EffectsWidget_1.windowManager.buildFromXML(_loc5_.content as XML) as IWindowController_1;
         _window.addChild(_loc6_);
         var _loc3_:ITextWindow = _window.findChildByName("effect_name") as ITextWindow;
         if(_loc3_ != null)
         {
            _loc3_.caption = "${fx_" + _effect.type + "}";
         }
         var _loc8_:ITextWindow = _window.findChildByName("effect_amount") as ITextWindow;
         if(_loc8_ != null)
         {
            _loc8_.caption = _effect.amountInInventory + "";
         }
         var _loc1_:IWindowController_1 = _window.findChildByName("effect_amount_bg1") as IWindowController_1;
         if(_effect.amountInInventory < 2)
         {
            if(_loc1_ != null)
            {
               _loc1_.visible = false;
            }
         }
         if(_loc2_ == "memenu_effect_inactive")
         {
            _loc4_ = _window.findChildByName("activate_effect") as UnknownICoreWindowComponents4;
            if(_loc4_ != null)
            {
               _loc4_.addEventListener("WME_CLICK",onMouseEvent);
            }
         }
         else
         {
            _loc6_.addEventListener("WME_CLICK",onMouseEvent);
            if(_effect.isActive)
            {
               _loc6_.addEventListener("WME_OVER",onMouseEvent);
               _loc6_.addEventListener("WME_OUT",onMouseEvent);
            }
            if(_effect.isInUse)
            {
               setElementImage("effect_hilite","memenu_fx_pause");
            }
            else
            {
               setElementImage("effect_hilite","memenu_fx_play");
            }
            _hilite = _window.findChildByName("effect_hilite");
            _hilite.visible = false;
         }
         setTimeLeft();
         _bar = _window.findChildByName("loader_bar");
         if(_bar != null)
         {
            _maxWidth = _bar.width;
            UnknownVarFromEffectView_Timer_1.start();
            onUpdate();
         }
         if(_effect.icon)
         {
            setElementBitmap("effect_icon",_effect.icon);
         }
         _window.rectangle = _loc6_.rectangle;
      }
      
      private function setElementBitmap(param1:String, param2:BitmapData) : void
      {
         var _loc3_:IBitmapWrapperController = _window.findChildByName(param1) as IBitmapWrapperController;
         if(_loc3_ != null)
         {
            if(_loc3_.bitmap)
            {
               _loc3_.bitmap.dispose();
            }
            _loc3_.bitmap = new BitmapData(_loc3_.width,_loc3_.height,true,0);
            _loc3_.bitmap.copyPixels(param2,param2.rect,new Point(0,0));
         }
      }
      
      private function onMouseEvent(param1:WindowMouseEvent) : void
      {
         switch(param1.type)
         {
            case "WME_OVER":
               if(_hilite != null)
               {
                  _hilite.visible = true;
               }
               break;
            case "WME_OUT":
               if(_hilite != null)
               {
                  _hilite.visible = false;
               }
               break;
            case "WME_CLICK":
               UnknownVarFromEffectView_EffectsWidget_1.selectEffect(_effect.type,_effect.isInUse);
         }
      }
      
      private function setElementImage(param1:String, param2:String) : void
      {
         var _loc4_:BitmapDataAsset = UnknownVarFromEffectView_EffectsWidget_1.assets.getAssetByName(param2) as BitmapDataAsset;
         var _loc3_:BitmapData = _loc4_.content as BitmapData;
         setElementBitmap(param1,_loc3_);
      }
   }
}

