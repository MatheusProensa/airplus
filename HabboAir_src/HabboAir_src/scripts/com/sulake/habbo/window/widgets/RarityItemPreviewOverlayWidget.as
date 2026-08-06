package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   
   public class RarityItemPreviewOverlayWidget implements IRarityItemPreviewOverlayWidget
   {
      public static const TYPE:String = "rarity_item_overlay_preview";
      
      private static const UnknownConstFromRarityItemPreviewOverlayWidget_String_1:String = "rarity_item_overlay_preview:level";
      
      private static const RARITY_LEVEL_DEFAULT:PropertyStruct = new PropertyStruct("rarity_item_overlay_preview:level",0,"int");
      
      private var UnknownVarFromRarityItemPreviewOverlayWidget_IWidgetWindowController_1:IWidgetWindowController;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var UnknownVarFromRarityItemPreviewOverlayWidget_IWindowController_1_1:IWindowController_1;
      
      private var _rarityLevel:int;
      
      private var _disposed:Boolean;
      
      private var UnknownVarFromRarityItemPreviewOverlayWidget_ITextWindow_1:ITextWindow;
      
      public function RarityItemPreviewOverlayWidget(param1:IWidgetWindowController, param2:HabboWindowManagerComponent)
      {
         super();
         UnknownVarFromRarityItemPreviewOverlayWidget_IWidgetWindowController_1 = param1;
         _windowManager = param2;
         UnknownVarFromRarityItemPreviewOverlayWidget_IWindowController_1_1 = IWindowController_1(_windowManager.buildFromXML(XML(_windowManager.assets.getAssetByName("rarity_item_overlay_preview_xml").content)));
         UnknownVarFromRarityItemPreviewOverlayWidget_ITextWindow_1 = UnknownVarFromRarityItemPreviewOverlayWidget_IWindowController_1_1.findChildByName("level") as ITextWindow;
         UnknownVarFromRarityItemPreviewOverlayWidget_IWidgetWindowController_1.rootWindow = UnknownVarFromRarityItemPreviewOverlayWidget_IWindowController_1_1;
      }
      
      public function set rarityLevel(param1:int) : void
      {
         _rarityLevel = param1;
         UnknownVarFromRarityItemPreviewOverlayWidget_ITextWindow_1.caption = param1.toString();
      }
      
      public function get rarityLevel() : int
      {
         return _rarityLevel;
      }
      
      public function get properties() : Array
      {
         var _loc1_:Array = [];
         if(_disposed)
         {
            return _loc1_;
         }
         _loc1_.push(RARITY_LEVEL_DEFAULT.withValue(rarityLevel));
         return _loc1_;
      }
      
      public function set properties(param1:Array) : void
      {
         for each(var _loc2_ in param1)
         {
            var _loc3_:* = _loc2_.key;
            if("rarity_item_overlay_preview:level" === _loc3_)
            {
               rarityLevel = int(_loc2_.value);
            }
         }
      }
      
      public function dispose() : void
      {
         if(!disposed)
         {
            if(UnknownVarFromRarityItemPreviewOverlayWidget_IWindowController_1_1 != null)
            {
               UnknownVarFromRarityItemPreviewOverlayWidget_IWindowController_1_1.dispose();
               UnknownVarFromRarityItemPreviewOverlayWidget_IWindowController_1_1 = null;
            }
         }
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get iterator() : IIterator
      {
         return EmptyIterator.INSTANCE;
      }
   }
}

