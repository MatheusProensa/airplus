package com.sulake.habbo.ui.widget.chooser.furni
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.widget.chooser.*;
   import com.sulake.habbo.ui.widget.events.RoomWidgetChooserContentEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetRequestWidgetMessage;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   
   public class FurniChooserWidget extends ChooserWidgetBase
   {
      private var UnknownVarFromFurniChooserWidget_FurniView_1:FurniView;
      
      private var _items:Array;
      
      private var UnknownVarFromFurniChooserWidget_Dictionary_1:Dictionary;
      
      public function FurniChooserWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection = null, param4:IHabboLocalizationManager = null)
      {
         super(param1,param2,param3,param4);
      }
      
      override public function dispose() : void
      {
         if(UnknownVarFromFurniChooserWidget_FurniView_1 != null)
         {
            UnknownVarFromFurniChooserWidget_FurniView_1.dispose();
            UnknownVarFromFurniChooserWidget_FurniView_1 = null;
         }
         super.dispose();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener("RWCCE_FURNI_CHOOSER_CONTENT",onChooserContent);
         param1.addEventListener("RWCCE_FURNI_CHOOSER_CONTENT_ADD",onChooserContentAdded);
         param1.addEventListener("RWROUE_FURNI_REMOVED",onUpdateFurniChooser);
         param1.addEventListener("RWROUE_FURNI_ADDED",onUpdateFurniChooser);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWCCE_FURNI_CHOOSER_CONTENT",onChooserContent);
         param1.removeEventListener("RWCCE_FURNI_CHOOSER_CONTENT_ADD",onChooserContentAdded);
         param1.removeEventListener("RWROUE_FURNI_REMOVED",onUpdateFurniChooser);
         param1.removeEventListener("RWROUE_FURNI_ADDED",onUpdateFurniChooser);
      }
      
      private function onChooserContent(param1:RoomWidgetChooserContentEvent) : void
      {
         if(param1 == null || param1.items == null)
         {
            return;
         }
         if(UnknownVarFromFurniChooserWidget_FurniView_1 == null)
         {
            UnknownVarFromFurniChooserWidget_FurniView_1 = new FurniView(this,"${widget.chooser.furni.title}");
         }
         _items = [];
         UnknownVarFromFurniChooserWidget_Dictionary_1 = new Dictionary();
         for each(var _loc2_ in param1.items)
         {
            if(_loc2_.id > 0)
            {
               _items.push(_loc2_);
               UnknownVarFromFurniChooserWidget_Dictionary_1[_loc2_.id] = true;
            }
         }
         _items.sortOn(["lowerCaseName","id"],[null,16]);
         UnknownVarFromFurniChooserWidget_FurniView_1.onItemsChanged();
      }
      
      private function onChooserContentAdded(param1:RoomWidgetChooserContentEvent) : void
      {
         if(param1 == null || param1.items == null || UnknownVarFromFurniChooserWidget_FurniView_1 == null || _items == null)
         {
            return;
         }
         var _loc3_:Boolean = false;
         for each(var _loc2_ in param1.items)
         {
            if(_loc2_.id > 0 && !(_loc2_.id in UnknownVarFromFurniChooserWidget_Dictionary_1))
            {
               _items.push(_loc2_);
               UnknownVarFromFurniChooserWidget_Dictionary_1[_loc2_.id] = true;
               _loc3_ = true;
            }
         }
         if(_loc3_)
         {
            UnknownVarFromFurniChooserWidget_FurniView_1.onItemsChanged();
         }
      }
      
      public function get items() : Array
      {
         return _items;
      }
      
      private function onUpdateFurniChooser(param1:RoomWidgetRoomObjectUpdateEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:ChooserItem = null;
         var _loc4_:RoomWidgetRequestWidgetMessage = null;
         if(UnknownVarFromFurniChooserWidget_FurniView_1 == null || !UnknownVarFromFurniChooserWidget_FurniView_1.isOpen())
         {
            return;
         }
         if(param1.type == "RWROUE_FURNI_REMOVED")
         {
            if(_items != null)
            {
               _loc3_ = 0;
               while(_loc3_ < _items.length)
               {
                  _loc2_ = _items[_loc3_];
                  if(_loc2_.id == param1.id && _loc2_.category == param1.category)
                  {
                     _items.removeAt(_loc3_);
                     delete UnknownVarFromFurniChooserWidget_Dictionary_1[_loc2_.id];
                     UnknownVarFromFurniChooserWidget_FurniView_1.onItemsChanged();
                     return;
                  }
                  _loc3_ += 1;
               }
            }
         }
         else if(param1.type == "RWROUE_FURNI_ADDED")
         {
            _loc4_ = new RoomWidgetRequestWidgetMessage("RWRWM_FURNI_CHOOSER_ADD",param1.id,param1.category);
            messageListener.processWidgetMessage(_loc4_);
         }
      }
   }
}

