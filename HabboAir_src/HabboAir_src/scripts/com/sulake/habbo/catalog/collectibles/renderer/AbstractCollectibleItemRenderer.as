package com.sulake.habbo.catalog.collectibles.renderer
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.collectibles.CollectiblesController;
   import com.sulake.habbo.catalog.collectibles.IRenderableCollectibleItem;
   import com.sulake.habbo.catalog.collectibles.tabs.subviews.CollectibleProductPreviewer;
   
   public class AbstractCollectibleItemRenderer
   {
      protected var UnknownVarFromAbstractCollectibleItemRenderer_CollectiblesController_1:CollectiblesController;
      
      private var _renderableItem:IRenderableCollectibleItem;
      
      private var _container:IWindowController_1;
      
      private var UnknownVarFromAbstractCollectibleItemRenderer_CollectibleProductPreviewer_1:CollectibleProductPreviewer;
      
      private var _active:Boolean = false;
      
      private var UnknownVarFromAbstractCollectibleItemRenderer_Boolean_1:Boolean = false;
      
      public function AbstractCollectibleItemRenderer(param1:CollectiblesController, param2:IRenderableCollectibleItem, param3:IWindowController_1)
      {
         super();
         UnknownVarFromAbstractCollectibleItemRenderer_CollectiblesController_1 = param1;
         _renderableItem = param2;
         _container = param3;
         _container.addEventListener("WME_CLICK",onClick);
         _container.addEventListener("WME_OVER",onOver);
         _container.addEventListener("WME_OUT",onOut);
         UnknownVarFromAbstractCollectibleItemRenderer_CollectibleProductPreviewer_1 = new CollectibleProductPreviewer(bitmapWindow,badgeImageWindow,petImageWindow,unknownImageWindow);
         UnknownVarFromAbstractCollectibleItemRenderer_CollectiblesController_1.previewIcon(_renderableItem,UnknownVarFromAbstractCollectibleItemRenderer_CollectibleProductPreviewer_1);
         updateVisuals();
         updateColoring();
      }
      
      public function updateVisuals() : void
      {
      }
      
      protected function onClick(param1:WindowMouseEvent) : void
      {
      }
      
      private function updateColoring() : void
      {
         var _loc2_:Object = isComplete ? completeColoring() : incompleteColoring();
         var _loc1_:Object = UnknownVarFromAbstractCollectibleItemRenderer_Boolean_1 ? _loc2_.hovered : (_active ? _loc2_.active : _loc2_.normal);
         borderOutline.color = _loc1_.outline;
         borderBackground.color = _loc1_.background;
      }
      
      protected function incompleteColoring() : Object
      {
         return {
            "active":{
               "background":15132390,
               "outline":16777215
            },
            "hovered":{
               "background":14409183,
               "outline":16119544
            },
            "normal":{
               "background":13159891,
               "outline":9412017
            }
         };
      }
      
      protected function completeColoring() : Object
      {
         return {
            "active":{
               "background":14872032,
               "outline":16777215
            },
            "hovered":{
               "background":14346200,
               "outline":16119544
            },
            "normal":{
               "background":13820623,
               "outline":8823170
            }
         };
      }
      
      protected function get isComplete() : Boolean
      {
         return _renderableItem.amount > 0;
      }
      
      public function activate() : void
      {
         _active = true;
         updateColoring();
      }
      
      public function deactivate() : void
      {
         _active = false;
         updateColoring();
      }
      
      private function onOut(param1:WindowMouseEvent) : void
      {
         UnknownVarFromAbstractCollectibleItemRenderer_Boolean_1 = false;
         updateColoring();
      }
      
      private function onOver(param1:WindowMouseEvent) : void
      {
         UnknownVarFromAbstractCollectibleItemRenderer_Boolean_1 = true;
         updateColoring();
      }
      
      public function dispose() : void
      {
         if(_container)
         {
            _container.dispose();
            _container = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
      
      public function get renderableItem() : IRenderableCollectibleItem
      {
         return _renderableItem;
      }
      
      public function get container() : IWindowController_1
      {
         return _container;
      }
      
      protected function get borderOutline() : UnknownICoreWindowComponents6
      {
         return null;
      }
      
      protected function get borderBackground() : UnknownICoreWindowComponents6
      {
         return null;
      }
      
      protected function get amountText() : ITextWindow
      {
         return null;
      }
      
      protected function get amountTextBorder() : UnknownICoreWindowComponents6
      {
         return null;
      }
      
      protected function get bitmapWindow() : IBitmapWrapperController
      {
         return null;
      }
      
      protected function get unknownImageWindow() : IStaticBitmapWrapperWindow
      {
         return null;
      }
      
      protected function get badgeImageWindow() : IWidgetWindowController
      {
         return null;
      }
      
      protected function get petImageWindow() : IWidgetWindowController
      {
         return null;
      }
   }
}

