package com.sulake.habbo.ui.widget.uihelpbubbles
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IBubbleController;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowMouseEvent;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class UiHelpBubble
   {
      private var _window:IWindowController_1;
      
      private var UnknownVarFromUiHelpBubble_UiHelpBubblesWidget_1:UiHelpBubblesWidget;
      
      private var _name:String;
      
      private var UnknownVarFromUiHelpBubble_Point_1:Point;
      
      private var UnknownVarFromUiHelpBubble_String_1:String;
      
      private var UnknownVarFromUiHelpBubble_Boolean_1:Boolean;
      
      private var _bubble:IBubbleController;
      
      private var UnknownVarFromUiHelpBubble_UnknownICoreWindowComponents4_1:UnknownICoreWindowComponents4;
      
      private var UnknownVarFromUiHelpBubble_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromUiHelpBubble_Boolean_2:Boolean;
      
      private var UnknownVarFromUiHelpBubble_IBitmapWrapperController_1:IBitmapWrapperController;
      
      private var UnknownVarFromUiHelpBubble_IWindowModel_1:IWindowModel;
      
      private var UnknownVarFromUiHelpBubble_IWindowModel_2:IWindowModel;
      
      private var UnknownVarFromUiHelpBubble_Function_1:Function;
      
      public function UiHelpBubble(param1:UiHelpBubblesWidget, param2:HelpBubbleItem, param3:Boolean)
      {
         super();
         UnknownVarFromUiHelpBubble_UiHelpBubblesWidget_1 = param1;
         _name = param2.name;
         UnknownVarFromUiHelpBubble_String_1 = param2.text;
         UnknownVarFromUiHelpBubble_Boolean_1 = param3;
         UnknownVarFromUiHelpBubble_Boolean_2 = param2.modal;
         createWindow();
      }
      
      public function dispose() : void
      {
         UnknownVarFromUiHelpBubble_UiHelpBubblesWidget_1 = null;
         if(UnknownVarFromUiHelpBubble_IWindowModel_1 != null && UnknownVarFromUiHelpBubble_Function_1 != null)
         {
            UnknownVarFromUiHelpBubble_IWindowModel_1.removeEventListener("WME_CLICK",UnknownVarFromUiHelpBubble_Function_1);
         }
         if(UnknownVarFromUiHelpBubble_IWindowController_1_1)
         {
            UnknownVarFromUiHelpBubble_IWindowController_1_1.dispose();
            UnknownVarFromUiHelpBubble_IWindowController_1_1 = null;
         }
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      private function addMouseClickListener(param1:IWindowModel, param2:Function) : void
      {
         if(param1 != null)
         {
            param1.setParamFlag(1,true);
            param1.addEventListener("WME_CLICK",param2);
         }
      }
      
      private function createWindow() : void
      {
         var _loc4_:XmlAsset = null;
         var _loc1_:int = 0;
         if(!UnknownVarFromUiHelpBubble_UiHelpBubblesWidget_1 || !UnknownVarFromUiHelpBubble_UiHelpBubblesWidget_1.assets || !UnknownVarFromUiHelpBubble_UiHelpBubblesWidget_1.windowManager)
         {
            return;
         }
         if(UnknownVarFromUiHelpBubble_Boolean_2)
         {
            _loc4_ = UnknownVarFromUiHelpBubble_UiHelpBubblesWidget_1.assets.getAssetByName("ui_help_modal") as XmlAsset;
            UnknownVarFromUiHelpBubble_IWindowController_1_1 = UnknownVarFromUiHelpBubble_UiHelpBubblesWidget_1.windowManager.buildFromXML(_loc4_.content as XML,3) as IWindowController_1;
         }
         if(UnknownVarFromUiHelpBubble_IWindowController_1_1)
         {
            UnknownVarFromUiHelpBubble_IWindowController_1_1.width = UnknownVarFromUiHelpBubble_IWindowController_1_1.desktop.width;
            UnknownVarFromUiHelpBubble_IWindowController_1_1.height = UnknownVarFromUiHelpBubble_IWindowController_1_1.desktop.height;
            UnknownVarFromUiHelpBubble_IBitmapWrapperController_1 = UnknownVarFromUiHelpBubble_IWindowController_1_1.findChildByName("bitmap") as IBitmapWrapperController;
            addMouseClickListener(UnknownVarFromUiHelpBubble_IBitmapWrapperController_1,onActivateBubble);
         }
         var _loc2_:XmlAsset = UnknownVarFromUiHelpBubble_UiHelpBubblesWidget_1.assets.getAssetByName("ui_help_bubble") as XmlAsset;
         if(!_loc2_)
         {
            return;
         }
         _window = UnknownVarFromUiHelpBubble_UiHelpBubblesWidget_1.windowManager.buildFromXML(_loc2_.content as XML,3) as IWindowController_1;
         if(!_window)
         {
            return;
         }
         UnknownVarFromUiHelpBubble_UnknownICoreWindowComponents4_1 = _window.findChildByName("help_bubble_btn_ok") as UnknownICoreWindowComponents4;
         _bubble = _window.findChildByName("bubble") as IBubbleController;
         var _loc3_:ITextWindow = _window.findChildByName("help_bubble_text") as ITextWindow;
         if(_loc3_)
         {
            _loc3_.text = UnknownVarFromUiHelpBubble_String_1;
            _loc1_ = _loc3_.textHeight;
            _window.height = _loc1_ + 90;
            UnknownVarFromUiHelpBubble_UnknownICoreWindowComponents4_1.y = _loc1_ + 30;
         }
         if(!UnknownVarFromUiHelpBubble_Boolean_1)
         {
            UnknownVarFromUiHelpBubble_UnknownICoreWindowComponents4_1.caption = UnknownVarFromUiHelpBubble_UiHelpBubblesWidget_1.localizations.getLocalization("alert.close.button","alert.close.button");
            addMouseClickListener(UnknownVarFromUiHelpBubble_UnknownICoreWindowComponents4_1,onLastBubble);
         }
         else
         {
            addMouseClickListener(UnknownVarFromUiHelpBubble_UnknownICoreWindowComponents4_1,onNext);
         }
         _window.visible = true;
      }
      
      public function show() : void
      {
         if(_window != null)
         {
            _window.visible = true;
            _window.activate();
         }
      }
      
      private function onActivateBubble(param1:WindowMouseEvent) : void
      {
         UnknownVarFromUiHelpBubble_IWindowController_1_1.deactivate();
         _window.activate();
      }
      
      private function onNext(param1:WindowMouseEvent) : void
      {
         if(!UnknownVarFromUiHelpBubble_UiHelpBubblesWidget_1)
         {
            return;
         }
         if(UnknownVarFromUiHelpBubble_IWindowController_1_1)
         {
            UnknownVarFromUiHelpBubble_IWindowController_1_1.visible = false;
         }
         UnknownVarFromUiHelpBubble_UiHelpBubblesWidget_1.removeHelpBubble(_name);
      }
      
      private function onLastBubble(param1:WindowMouseEvent) : void
      {
         if(!UnknownVarFromUiHelpBubble_UiHelpBubblesWidget_1)
         {
            return;
         }
         UnknownVarFromUiHelpBubble_UiHelpBubblesWidget_1.sendScriptProceedMessage();
         if(UnknownVarFromUiHelpBubble_IWindowController_1_1)
         {
            UnknownVarFromUiHelpBubble_IWindowController_1_1.visible = false;
         }
         UnknownVarFromUiHelpBubble_UiHelpBubblesWidget_1.removeHelpBubble(_name);
      }
      
      public function setModal(param1:Rectangle) : void
      {
         if(!UnknownVarFromUiHelpBubble_IBitmapWrapperController_1)
         {
            return;
         }
         var _loc3_:BitmapData = new BitmapData(UnknownVarFromUiHelpBubble_IWindowController_1_1.width,UnknownVarFromUiHelpBubble_IWindowController_1_1.height,true,4292870144);
         var _loc2_:BitmapData = new BitmapData(param1.width,param1.height,true,16777215);
         _loc3_.copyPixels(_loc2_,_loc2_.rect,new Point(param1.x,param1.y));
         UnknownVarFromUiHelpBubble_IBitmapWrapperController_1.bitmap = _loc3_;
         UnknownVarFromUiHelpBubble_IBitmapWrapperController_1.invalidate();
      }
      
      public function setPosition(param1:Point) : void
      {
         UnknownVarFromUiHelpBubble_Point_1 = param1;
         _window.y = UnknownVarFromUiHelpBubble_Point_1.y;
         _window.x = UnknownVarFromUiHelpBubble_Point_1.x - _window.width / 2;
      }
      
      public function setArrowPos(param1:String, param2:int) : void
      {
         _bubble.direction = param1;
         _bubble.pointerOffset = param2 - 8;
      }
      
      public function setCallback(param1:IWindowModel) : void
      {
         if(UnknownVarFromUiHelpBubble_Function_1 != null)
         {
            return;
         }
         UnknownVarFromUiHelpBubble_IWindowModel_1 = param1;
         if(!UnknownVarFromUiHelpBubble_Boolean_1)
         {
            UnknownVarFromUiHelpBubble_Function_1 = onLastBubble;
         }
         else
         {
            UnknownVarFromUiHelpBubble_Function_1 = onNext;
         }
         UnknownVarFromUiHelpBubble_IWindowModel_1.addEventListener("WME_CLICK",UnknownVarFromUiHelpBubble_Function_1);
      }
      
      public function setChatFieldCallback(param1:ITextFieldWindow) : void
      {
         if(UnknownVarFromUiHelpBubble_Function_1 != null)
         {
            return;
         }
         UnknownVarFromUiHelpBubble_IWindowModel_2 = param1;
         if(!UnknownVarFromUiHelpBubble_Boolean_1)
         {
            UnknownVarFromUiHelpBubble_Function_1 = onLastBubble;
         }
         else
         {
            UnknownVarFromUiHelpBubble_Function_1 = onNext;
         }
         UnknownVarFromUiHelpBubble_IWindowModel_2.addEventListener("WME_CLICK",UnknownVarFromUiHelpBubble_Function_1);
      }
      
      public function getWindow() : IWindowController_1
      {
         return _window;
      }
      
      public function getName() : String
      {
         return _name;
      }
   }
}

