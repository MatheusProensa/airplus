package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.UnknownIHabboCatalog1;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetRoomChangedEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.communication.messages.incoming.room.permissions.YouAreOwnerMessageEvent;
   
   public class BuilderCatalogWidget extends CatalogWidget implements ICatalogWidget, IComponentInterfaceQueue
   {
      private var _catalog:HabboCatalog;
      
      private var _offer:UnknownIHabboCatalog1;
      
      private var UnknownVarFromBuilderCatalogWidget_YouAreOwnerMessageEvent_1:YouAreOwnerMessageEvent;
      
      public function BuilderCatalogWidget(param1:IWindowController_1, param2:HabboCatalog)
      {
         super(param1);
         _catalog = param2;
         UnknownVarFromBuilderCatalogWidget_YouAreOwnerMessageEvent_1 = new YouAreOwnerMessageEvent(onYouAreOwner);
         _catalog.connection.addMessageEvent(UnknownVarFromBuilderCatalogWidget_YouAreOwnerMessageEvent_1);
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(_catalog != null && _catalog.connection != null)
         {
            _catalog.connection.removeMessageEvent(UnknownVarFromBuilderCatalogWidget_YouAreOwnerMessageEvent_1);
            UnknownVarFromBuilderCatalogWidget_YouAreOwnerMessageEvent_1 = null;
            _catalog = null;
         }
         events.removeEventListener("SELECT_PRODUCT",onSelectProduct);
         super.dispose();
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         if(!page.isBuilderPage)
         {
            _window.visible = false;
            return true;
         }
         attachWidgetView("builderWidget");
         updateButtons(false);
         _window.procedure = windowProcedure;
         events.addEventListener("SELECT_PRODUCT",onSelectProduct);
         events.addEventListener("CWE_ROOM_CHANGED",onRoomChanged);
         return true;
      }
      
      private function onRoomChanged(param1:CatalogWidgetRoomChangedEvent) : void
      {
         updateButtons(false);
      }
      
      private function onYouAreOwner(param1:YouAreOwnerMessageEvent) : void
      {
         if(!page.isBuilderPage)
         {
            return;
         }
         updateButtons(true);
      }
      
      private function windowProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "place_one":
               _catalog.requestSelectedItemToMover(null,_offer);
               break;
            case "place_many":
               _catalog.requestSelectedItemToMover(null,_offer,true);
         }
      }
      
      private function onSelectProduct(param1:SelectProductEvent) : void
      {
         _offer = param1.offer;
         updateButtons(false);
      }
      
      private function updateButtons(param1:Boolean) : void
      {
         var _loc2_:IStaticBitmapWrapperWindow = null;
         var _loc4_:IWindowModel = null;
         if(!_window || !_window.visible)
         {
            return;
         }
         var _loc3_:int = _catalog.getBuilderFurniPlaceableStatusForOffer(_offer);
         if(_loc3_ == 4 && param1)
         {
            _loc3_ = 0;
         }
         if(_loc3_ == 0)
         {
            UnknownICoreWindowComponents4(_window.findChildByName("place_one")).enable();
            UnknownICoreWindowComponents4(_window.findChildByName("place_many")).enable();
            _window.findChildByName("error_container").visible = false;
         }
         else
         {
            UnknownICoreWindowComponents4(_window.findChildByName("place_one")).disable();
            UnknownICoreWindowComponents4(_window.findChildByName("place_many")).disable();
            _window.findChildByName("error_container").visible = true;
            _loc2_ = _window.findChildByName("error_icon") as IStaticBitmapWrapperWindow;
            _loc4_ = _window.findChildByName("error_message");
            switch(_loc3_ - 1)
            {
               case 0:
                  _window.findChildByName("error_container").visible = false;
                  break;
               case 1:
                  _loc2_.assetUri = "icons_builder_error_furnilimit";
                  _loc4_.caption = "${builder.placement_widget.error.limit_reached}";
                  break;
               case 2:
                  _loc2_.assetUri = "icons_builder_error_notroom";
                  _loc4_.caption = "${builder.placement_widget.error.not_in_room}";
                  break;
               case 3:
                  _loc2_.assetUri = "icons_builder_error_room";
                  _loc4_.caption = "${builder.placement_widget.error.not_group_admin}";
                  break;
               case 4:
                  _loc2_.assetUri = "icons_builder_error_grouproom";
                  _loc4_.caption = "${builder.placement_widget.error.group_room}";
                  break;
               case 5:
                  _loc2_.assetUri = "icons_builder_error_userinroom";
                  _loc4_.caption = "${builder.placement_widget.error.visitors}";
            }
         }
      }
   }
}

