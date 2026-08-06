package com.sulake.habbo.ui.widget.furniture.clothingchange
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetClothingChangeUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetClothingChangeMessage;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.events.IEventDispatcher;
   import flash.geom.Rectangle;
   
   public class ClothingChangeFurnitureWidget extends RoomWidgetBase
   {
      private static const UnknownConstFromClothingChangeFurnitureWidget_String_1:String = "Boy";
      
      private static const UnknownConstFromClothingChangeFurnitureWidget_String_2:String = "Girl";
      
      private var UnknownVarFromClothingChangeFurnitureWidget_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromClothingChangeFurnitureWidget_Int_1:int = 0;
      
      private var UnknownVarFromClothingChangeFurnitureWidget_Int_2:int = 0;
      
      private var UnknownVarFromClothingChangeFurnitureWidget_Int_3:int = 0;
      
      public function ClothingChangeFurnitureWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection = null, param4:IHabboLocalizationManager = null)
      {
         super(param1,param2,param3,param4);
      }
      
      override public function dispose() : void
      {
         hideGenderSelectionInterface();
         super.dispose();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener("RWCCUE_SHOW_GENDER_SELECTION",onUpdate);
         param1.addEventListener("RWCCUE_SHOW_CLOTHING_EDITOR",onUpdate);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWCCUE_SHOW_GENDER_SELECTION",onUpdate);
         param1.removeEventListener("RWCCUE_SHOW_CLOTHING_EDITOR",onUpdate);
      }
      
      private function onUpdate(param1:RoomWidgetClothingChangeUpdateEvent) : void
      {
         var _loc2_:* = param1.type;
         if("RWCCUE_SHOW_GENDER_SELECTION" === _loc2_)
         {
            showGenderSelectionInterface(param1);
         }
      }
      
      private function showGenderSelectionInterface(param1:RoomWidgetClothingChangeUpdateEvent) : void
      {
         hideGenderSelectionInterface();
         UnknownVarFromClothingChangeFurnitureWidget_Int_1 = param1.objectId;
         UnknownVarFromClothingChangeFurnitureWidget_Int_2 = param1.objectCategory;
         UnknownVarFromClothingChangeFurnitureWidget_Int_3 = param1.roomId;
         var _loc4_:ISoundAsset = assets.getAssetByName("boygirl");
         var _loc2_:XmlAsset = XmlAsset(_loc4_);
         if(_loc2_ == null)
         {
            return;
         }
         UnknownVarFromClothingChangeFurnitureWidget_IWindowController_1_1 = windowManager.createWindow("clothing change gender selection","",4,0,32768 | 1 | 131072 | 1,new Rectangle(100,100,200,200),null,0) as IWindowController_1;
         UnknownVarFromClothingChangeFurnitureWidget_IWindowController_1_1.buildFromXML(XML(_loc2_.content));
         UnknownVarFromClothingChangeFurnitureWidget_IWindowController_1_1.addEventListener("WME_CLICK",onGenderSelectionMouseEvent);
         UnknownVarFromClothingChangeFurnitureWidget_IWindowController_1_1.center();
         var _loc3_:IWindowModel = UnknownVarFromClothingChangeFurnitureWidget_IWindowController_1_1.findChildByTag("close");
         if(_loc3_ != null)
         {
            _loc3_.procedure = onGenderSelectionWindowClose;
         }
         _loc3_ = UnknownVarFromClothingChangeFurnitureWidget_IWindowController_1_1.findChildByName("Boy");
         if(_loc3_ != null)
         {
            _loc3_.addEventListener("WME_CLICK",onGenderSelectionMouseEvent);
         }
         _loc3_ = UnknownVarFromClothingChangeFurnitureWidget_IWindowController_1_1.findChildByName("Girl");
         if(_loc3_ != null)
         {
            _loc3_.addEventListener("WME_CLICK",onGenderSelectionMouseEvent);
         }
      }
      
      private function hideGenderSelectionInterface() : void
      {
         if(UnknownVarFromClothingChangeFurnitureWidget_IWindowController_1_1 != null)
         {
            UnknownVarFromClothingChangeFurnitureWidget_IWindowController_1_1.dispose();
            UnknownVarFromClothingChangeFurnitureWidget_IWindowController_1_1 = null;
         }
      }
      
      private function onGenderSelectionWindowClose(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         hideGenderSelectionInterface();
      }
      
      private function onGenderSelectionMouseEvent(param1:WindowMouseEvent) : void
      {
         var _loc2_:IWindowModel = param1.target as IWindowModel;
         var _loc3_:String = _loc2_.name;
         switch(_loc3_)
         {
            case "Boy":
               requestEditor("M");
               hideGenderSelectionInterface();
               break;
            case "Girl":
               requestEditor("F");
               hideGenderSelectionInterface();
               break;
            case "close":
            case "close_btn":
               hideGenderSelectionInterface();
         }
      }
      
      private function requestEditor(param1:String) : void
      {
         var _loc2_:RoomWidgetClothingChangeMessage = new RoomWidgetClothingChangeMessage("RWCCM_REQUEST_EDITOR",param1,UnknownVarFromClothingChangeFurnitureWidget_Int_1,UnknownVarFromClothingChangeFurnitureWidget_Int_2,UnknownVarFromClothingChangeFurnitureWidget_Int_3);
         messageListener.processWidgetMessage(_loc2_);
      }
   }
}

