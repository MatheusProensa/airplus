package com.sulake.habbo.ui.widget.crafting.renderer
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.room.UnknownHabboRoom1;
   import com.sulake.habbo.room.UnknownIHabboRoom1;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.ui.widget.crafting.CraftingWidget;
   import com.sulake.habbo.ui.widget.crafting.utils.CraftingFurnitureItem;
   import flash.display.BitmapData;
   
   public class FurniThumbnailRendererBase implements UnknownIHabboRoom1
   {
      private const THUMB_BLEND_ITEMS_AVAILABLE:Number = 1;
      
      private const THUMB_BLEND_ITEMS_NOT_AVAILABLE:Number = 0.2;
      
      protected var UnknownVarFromFurniThumbnailRendererBase_CraftingWidget_1:CraftingWidget;
      
      protected var _content:CraftingFurnitureItem;
      
      protected var _window:IWindowController_1;
      
      public function FurniThumbnailRendererBase(param1:CraftingFurnitureItem, param2:IWindowController_1, param3:CraftingWidget)
      {
         super();
         UnknownVarFromFurniThumbnailRendererBase_CraftingWidget_1 = param3;
         _window = param2;
         _content = param1;
         requestIconFromRoomEngine(furnitureData);
         updateItemCount();
         _window.procedure = onMouseDown;
         var _loc4_:IRegionWindow = param2.findChildByName("tooltip") as IRegionWindow;
         _loc4_.toolTipCaption = param1.furnitureData.localizedName;
      }
      
      public function dispose() : void
      {
         if(_window)
         {
            _window.removeEventListener("mouseDown",onMouseDown);
            _window.dispose();
            _window = null;
         }
      }
      
      private function requestIconFromRoomEngine(param1:IFurnitureData) : void
      {
         var _loc2_:UnknownHabboRoom1 = null;
         switch(param1.type)
         {
            case "s":
               _loc2_ = UnknownVarFromFurniThumbnailRendererBase_CraftingWidget_1.handler.container.roomEngine.getFurnitureIcon(param1.id,this);
               break;
            case "i":
               _loc2_ = UnknownVarFromFurniThumbnailRendererBase_CraftingWidget_1.handler.container.roomEngine.getWallItemIcon(param1.id,this);
         }
         if(_loc2_.data)
         {
            imageReady(0,_loc2_.data);
         }
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         if(!_window)
         {
            return;
         }
         var _loc3_:IBitmapWrapperController = _window.findChildByTag("BITMAP") as IBitmapWrapperController;
         if(_loc3_ && param2)
         {
            _loc3_.bitmap = param2;
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      public function updateItemCount() : void
      {
      }
      
      protected function hideItemCount() : void
      {
         var _loc1_:IWindowModel = _window.findChildByName("number_container");
         if(_loc1_)
         {
            _loc1_.visible = false;
         }
      }
      
      protected function updateGroupItemCount(param1:int) : void
      {
         var _loc3_:ITextWindow = null;
         if(!_window || Boolean(_window.disposed))
         {
            return;
         }
         var _loc2_:IWindowModel = _window.findChildByName("number_container");
         _loc2_.visible = param1 > 0;
         if(param1 > 0)
         {
            _loc3_ = _window.findChildByName("number") as ITextWindow;
            _loc3_.text = String(param1);
         }
      }
      
      protected function updateBitmapBlend(param1:Boolean) : void
      {
         var _loc2_:IBitmapWrapperController = _window.findChildByName("bitmap") as IBitmapWrapperController;
         if(param1)
         {
            _loc2_.blend = 1;
         }
         else
         {
            _loc2_.blend = 0.2;
         }
      }
      
      private function onMouseDown(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_DOWN")
         {
            return;
         }
         onTriggered();
      }
      
      protected function onTriggered() : void
      {
      }
      
      public function get content() : CraftingFurnitureItem
      {
         return _content;
      }
      
      protected function get furnitureData() : IFurnitureData
      {
         return !!content ? content.furnitureData : null;
      }
      
      public function get window() : IWindowController_1
      {
         return _window;
      }
   }
}

