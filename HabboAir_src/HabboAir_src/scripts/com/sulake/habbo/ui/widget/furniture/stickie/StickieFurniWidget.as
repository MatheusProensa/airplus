package com.sulake.habbo.ui.widget.furniture.stickie
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetStickieDataUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetStickieSendUpdateMessage;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.display.BitmapData;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class StickieFurniWidget extends RoomWidgetBase
   {
      private static const FIELD_MAX_LINES:int = 14;
      
      private static const FIELD_MAX_CHARS:int = 500;
      
      private static const UnknownConstFromStickieFurniWidget_Number_1:Number = 100;
      
      private static const UnknownConstFromStickieFurniWidget_Number_2:Number = 100;
      
      private static const COLOR_BUTTON_NAMES:Array = ["blue","purple","green","yellow","white","red","orange","cyan"];
      
      private var _window:IWindowController_1;
      
      protected var UnknownVarFromStickieFurniWidget_Int_1:int = -1;
      
      protected var UnknownVarFromStickieFurniWidget_String_1:String;
      
      protected var _text:String;
      
      protected var UnknownVarFromStickieFurniWidget_String_2:String;
      
      protected var UnknownVarFromStickieFurniWidget_Boolean_1:Boolean;
      
      private var UnknownVarFromStickieFurniWidget_BitmapData_1:BitmapData;
      
      protected var _windowName:String = "stickieui_container";
      
      public function StickieFurniWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection = null)
      {
         super(param1,param2,param3);
      }
      
      protected function get window() : IWindowController_1
      {
         return _window;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         hideInterface();
         if(UnknownVarFromStickieFurniWidget_BitmapData_1)
         {
            UnknownVarFromStickieFurniWidget_BitmapData_1.dispose();
         }
         super.dispose();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener("RWSDUE_STICKIE_DATA",onObjectUpdate);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWSDUE_STICKIE_DATA",onObjectUpdate);
      }
      
      protected function onObjectUpdate(param1:RoomWidgetStickieDataUpdateEvent) : void
      {
         hideInterface(false);
         UnknownVarFromStickieFurniWidget_Int_1 = param1.objectId;
         UnknownVarFromStickieFurniWidget_String_1 = param1.objectType;
         _text = param1.text;
         UnknownVarFromStickieFurniWidget_String_2 = param1.colorHex;
         UnknownVarFromStickieFurniWidget_Boolean_1 = param1.controller;
         showInterface();
      }
      
      protected function showInterface() : void
      {
         var _loc7_:ITextFieldWindow = null;
         var _loc4_:BitmapDataAsset = null;
         var _loc3_:BitmapData = null;
         var _loc2_:IBitmapWrapperController = null;
         var _loc6_:String = null;
         if(UnknownVarFromStickieFurniWidget_Int_1 == -1)
         {
            return;
         }
         var _loc5_:ISoundAsset = assets.getAssetByName("stickie");
         if(_loc5_ == null)
         {
            return;
         }
         var _loc1_:XmlAsset = XmlAsset(_loc5_);
         if(_loc1_ == null)
         {
            return;
         }
         if(_window == null)
         {
            _window = windowManager.createWindow(_windowName,"",4,0,131072 | 1,new Rectangle(100,100,2,2),null,0) as IWindowController_1;
            _window.buildFromXML(XML(_loc1_.content));
         }
         _loc7_ = _window.findChildByName("text") as ITextFieldWindow;
         if(_loc7_ != null)
         {
            _loc7_.text = _text;
            _loc7_.addEventListener("WE_CHANGE",onTextWindowEvent);
         }
         _loc2_ = _window.findChildByTag("bg") as IBitmapWrapperController;
         if(_loc2_ != null)
         {
            _loc6_ = UnknownVarFromStickieFurniWidget_String_1.replace("post_it","stickie");
            if(assets.hasAsset(_loc6_) && assets.getAssetByName(_loc6_) is BitmapDataAsset)
            {
               _loc4_ = assets.getAssetByName(_loc6_) as BitmapDataAsset;
            }
            else
            {
               _loc4_ = assets.getAssetByName("stickie_blanco") as BitmapDataAsset;
               _loc2_.color = uint("0xFF" + UnknownVarFromStickieFurniWidget_String_2);
            }
            _loc3_ = _loc4_.content as BitmapData;
            if(UnknownVarFromStickieFurniWidget_BitmapData_1)
            {
               _loc3_ = UnknownVarFromStickieFurniWidget_BitmapData_1;
            }
            _loc2_.bitmap = new BitmapData(_loc2_.width,_loc2_.height,true,0);
            _loc2_.bitmap.copyPixels(_loc3_,_loc3_.rect,new Point(0,0));
         }
         _loc2_ = _window.findChildByTag("close_button") as IBitmapWrapperController;
         if(_loc2_ != null)
         {
            _loc4_ = assets.getAssetByName("stickie_close") as BitmapDataAsset;
            _loc3_ = _loc4_.content as BitmapData;
            _loc2_.bitmap = new BitmapData(_loc2_.width,_loc2_.height,true,0);
            _loc2_.bitmap.copyPixels(_loc3_,_loc3_.rect,new Point(0,0));
            _loc2_.addEventListener("WME_CLICK",onMouseEvent);
         }
         _loc2_ = _window.findChildByTag("delete_button") as IBitmapWrapperController;
         if(_loc2_ != null && UnknownVarFromStickieFurniWidget_Boolean_1)
         {
            _loc4_ = assets.getAssetByName("stickie_remove") as BitmapDataAsset;
            _loc3_ = _loc4_.content as BitmapData;
            _loc2_.bitmap = new BitmapData(_loc2_.width,_loc2_.height,true,0);
            _loc2_.bitmap.copyPixels(_loc3_,_loc3_.rect,new Point(0,0));
            _loc2_.addEventListener("WME_CLICK",onMouseEvent);
         }
         setColorButtons(UnknownVarFromStickieFurniWidget_Boolean_1 && UnknownVarFromStickieFurniWidget_String_1 == "post_it");
      }
      
      protected function hideInterface(param1:Boolean = true) : void
      {
         if(param1)
         {
            sendUpdate();
         }
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         UnknownVarFromStickieFurniWidget_Int_1 = -1;
         _text = null;
         UnknownVarFromStickieFurniWidget_Boolean_1 = false;
      }
      
      private function setColorButtons(param1:Boolean) : void
      {
         var _loc2_:IWindowModel = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < COLOR_BUTTON_NAMES.length)
         {
            _loc2_ = _window.findChildByName(COLOR_BUTTON_NAMES[_loc3_]);
            if(_loc2_ != null)
            {
               if(param1)
               {
                  _loc2_.visible = true;
                  _loc2_.addEventListener("WME_CLICK",onMouseEvent);
               }
               else
               {
                  _loc2_.visible = false;
               }
            }
            _loc3_++;
         }
      }
      
      protected function storeTextFromField() : Boolean
      {
         var _loc1_:ITextFieldWindow = _window.findChildByName("text") as ITextFieldWindow;
         if(_loc1_ == null)
         {
            return false;
         }
         if(_text == _loc1_.text)
         {
            return false;
         }
         _text = _loc1_.text;
         return true;
      }
      
      protected function sendUpdate() : void
      {
         var _loc1_:RoomWidgetStickieSendUpdateMessage = null;
         if(UnknownVarFromStickieFurniWidget_Int_1 == -1)
         {
            return;
         }
         if(!storeTextFromField())
         {
            return;
         }
         if(messageListener != null)
         {
            _loc1_ = new RoomWidgetStickieSendUpdateMessage("RWSUM_STICKIE_SEND_UPDATE",UnknownVarFromStickieFurniWidget_Int_1,_text,UnknownVarFromStickieFurniWidget_String_2);
            messageListener.processWidgetMessage(_loc1_);
         }
      }
      
      protected function sendSetColor(param1:uint) : void
      {
         var _loc3_:RoomWidgetStickieSendUpdateMessage = null;
         if(UnknownVarFromStickieFurniWidget_Int_1 == -1)
         {
            return;
         }
         storeTextFromField();
         var _loc2_:String = param1.toString(16).toUpperCase();
         if(_loc2_.length > 6)
         {
            _loc2_ = _loc2_.slice(_loc2_.length - 6,_loc2_.length);
         }
         if(_loc2_ == UnknownVarFromStickieFurniWidget_String_2)
         {
            return;
         }
         UnknownVarFromStickieFurniWidget_String_2 = _loc2_;
         if(messageListener != null)
         {
            _loc3_ = new RoomWidgetStickieSendUpdateMessage("RWSUM_STICKIE_SEND_UPDATE",UnknownVarFromStickieFurniWidget_Int_1,_text,UnknownVarFromStickieFurniWidget_String_2);
            messageListener.processWidgetMessage(_loc3_);
         }
         showInterface();
      }
      
      protected function sendDelete() : void
      {
         var _loc1_:RoomWidgetStickieSendUpdateMessage = null;
         if(UnknownVarFromStickieFurniWidget_Int_1 == -1)
         {
            return;
         }
         if(messageListener != null && UnknownVarFromStickieFurniWidget_Boolean_1)
         {
            _loc1_ = new RoomWidgetStickieSendUpdateMessage("RWSUM_STICKIE_SEND_DELETE",UnknownVarFromStickieFurniWidget_Int_1);
            messageListener.processWidgetMessage(_loc1_);
         }
      }
      
      private function onTextWindowEvent(param1:WindowEvent) : void
      {
         var _loc2_:ITextFieldWindow = null;
         _loc2_ = _window.findChildByName("text") as ITextFieldWindow;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.maxChars = 500;
         if(_loc2_.numLines < 14)
         {
            return;
         }
         _loc2_.text = _loc2_.text.slice(0,_loc2_.text.length - 1);
         _loc2_.maxChars = _loc2_.length;
      }
      
      protected function onMouseEvent(param1:WindowMouseEvent) : void
      {
         var _loc2_:IWindowModel = param1.target as IWindowModel;
         var _loc3_:String = _loc2_.name;
         switch(_loc3_)
         {
            case "blue":
            case "purple":
            case "green":
            case "yellow":
            case "white":
            case "red":
            case "orange":
            case "cyan":
               sendSetColor(_loc2_.color);
               break;
            case "close":
               hideInterface();
               break;
            case "delete":
               sendDelete();
               hideInterface(false);
         }
      }
   }
}

