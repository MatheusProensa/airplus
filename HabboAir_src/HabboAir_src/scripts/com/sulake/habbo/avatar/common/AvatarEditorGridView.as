package com.sulake.habbo.avatar.common
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IScrollableGridWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   
   public class AvatarEditorGridView implements IAvatarEditorGridView
   {
      public static const REMOVE_ITEM:String = "REMOVE_ITEM";
      
      public static const GET_MORE:String = "GET_MORE";
      
      private const MAX_COLOR_LAYERS:int = 2;
      
      private var UnknownVarFromAvatarEditorGridView_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromAvatarEditorGridView_ICategoryBaseModel_1_1:ICategoryBaseModel_1;
      
      private var UnknownVarFromAvatarEditorGridView_IItemGridWindow_1:IItemGridWindow;
      
      private var UnknownVarFromAvatarEditorGridView_Array_1:Array;
      
      private var UnknownVarFromAvatarEditorGridView_String_1:String;
      
      private var UnknownVarFromAvatarEditorGridView_IWindowModel_1:IWindowModel;
      
      private var UnknownVarFromAvatarEditorGridView_IWindowModel_2:IWindowModel;
      
      public function AvatarEditorGridView(param1:IWindowController_1)
      {
         super();
         UnknownVarFromAvatarEditorGridView_IWindowController_1_1 = param1;
         UnknownVarFromAvatarEditorGridView_IItemGridWindow_1 = UnknownVarFromAvatarEditorGridView_IWindowController_1_1.findChildByName("thumbs") as IItemGridWindow;
         UnknownVarFromAvatarEditorGridView_Array_1 = [];
         UnknownVarFromAvatarEditorGridView_Array_1.push(UnknownVarFromAvatarEditorGridView_IWindowController_1_1.findChildByName("palette0") as IItemGridWindow);
         UnknownVarFromAvatarEditorGridView_Array_1.push(UnknownVarFromAvatarEditorGridView_IWindowController_1_1.findChildByName("palette1") as IItemGridWindow);
         UnknownVarFromAvatarEditorGridView_IWindowModel_1 = UnknownVarFromAvatarEditorGridView_IWindowController_1_1.findChildByName("content_notification");
         UnknownVarFromAvatarEditorGridView_IWindowModel_2 = UnknownVarFromAvatarEditorGridView_IWindowController_1_1.findChildByName("content_title");
         UnknownVarFromAvatarEditorGridView_IWindowModel_1.visible = false;
         UnknownVarFromAvatarEditorGridView_IWindowModel_2.visible = false;
      }
      
      public function dispose() : void
      {
         if(UnknownVarFromAvatarEditorGridView_IItemGridWindow_1)
         {
            UnknownVarFromAvatarEditorGridView_IItemGridWindow_1.dispose();
            UnknownVarFromAvatarEditorGridView_IItemGridWindow_1 = null;
         }
         if(UnknownVarFromAvatarEditorGridView_Array_1)
         {
            for each(var _loc1_ in UnknownVarFromAvatarEditorGridView_Array_1)
            {
               if(_loc1_ != null)
               {
                  _loc1_.dispose();
                  _loc1_ = null;
               }
            }
            UnknownVarFromAvatarEditorGridView_Array_1 = null;
         }
         UnknownVarFromAvatarEditorGridView_ICategoryBaseModel_1_1 = null;
         if(UnknownVarFromAvatarEditorGridView_IWindowController_1_1)
         {
            UnknownVarFromAvatarEditorGridView_IWindowController_1_1.dispose();
            UnknownVarFromAvatarEditorGridView_IWindowController_1_1 = null;
         }
      }
      
      public function get window() : IWindowController_1
      {
         if(UnknownVarFromAvatarEditorGridView_IWindowController_1_1 == null)
         {
            return null;
         }
         if(UnknownVarFromAvatarEditorGridView_IWindowController_1_1.disposed)
         {
            return null;
         }
         return UnknownVarFromAvatarEditorGridView_IWindowController_1_1;
      }
      
      public function initFromList(param1:ICategoryBaseModel_1, param2:String) : void
      {
         var _loc3_:int = 0;
         var _loc6_:Array = null;
         var _loc4_:CategoryData = param1.getCategoryData(param2);
         if(!_loc4_)
         {
            return;
         }
         UnknownVarFromAvatarEditorGridView_IWindowController_1_1.visible = true;
         UnknownVarFromAvatarEditorGridView_ICategoryBaseModel_1_1 = param1;
         UnknownVarFromAvatarEditorGridView_String_1 = param2;
         UnknownVarFromAvatarEditorGridView_IItemGridWindow_1.removeGridItems();
         if(_loc4_.parts.length == 0)
         {
            UnknownVarFromAvatarEditorGridView_IWindowModel_2.visible = true;
            UnknownVarFromAvatarEditorGridView_IWindowModel_1.visible = true;
            showPalettes(0);
         }
         else
         {
            UnknownVarFromAvatarEditorGridView_IWindowModel_2.visible = false;
            UnknownVarFromAvatarEditorGridView_IWindowModel_1.visible = false;
            for each(var _loc8_ in UnknownVarFromAvatarEditorGridView_Array_1)
            {
               _loc8_.removeGridItems();
            }
            for each(var _loc5_ in _loc4_.parts)
            {
               if(_loc5_)
               {
                  UnknownVarFromAvatarEditorGridView_IItemGridWindow_1.addGridItem(_loc5_.view);
                  _loc5_.view.addEventListener("WME_CLICK",onGridItemClicked);
                  if(_loc5_.isSelected)
                  {
                     showPalettes(_loc5_.colorLayerCount);
                  }
               }
            }
            _loc3_ = 0;
            while(_loc3_ < 2)
            {
               _loc6_ = _loc4_.getPalette(_loc3_);
               _loc8_ = UnknownVarFromAvatarEditorGridView_Array_1[_loc3_] as IItemGridWindow;
               if(!(!_loc6_ || !_loc8_))
               {
                  for each(var _loc7_ in _loc6_)
                  {
                     _loc8_.addGridItem(_loc7_.view);
                     _loc7_.view.procedure = paletteEventProc;
                  }
               }
               _loc3_++;
            }
         }
      }
      
      public function showPalettes(param1:int) : void
      {
         var _loc4_:IScrollableGridWindow = UnknownVarFromAvatarEditorGridView_IWindowController_1_1.findChildByName("palette0") as IScrollableGridWindow;
         var _loc3_:IScrollableGridWindow = UnknownVarFromAvatarEditorGridView_IWindowController_1_1.findChildByName("palette1") as IScrollableGridWindow;
         if(_loc4_ == null || _loc3_ == null)
         {
            return;
         }
         var _loc5_:int = int(UnknownVarFromAvatarEditorGridView_IItemGridWindow_1.width);
         var _loc2_:int = (UnknownVarFromAvatarEditorGridView_IItemGridWindow_1.width - 10) / 2;
         if(param1 <= 0)
         {
            _loc4_.visible = false;
            _loc3_.visible = false;
         }
         else if(param1 == 1)
         {
            _loc4_.width = _loc5_;
            _loc4_.visible = true;
            _loc3_.visible = false;
         }
         else
         {
            _loc4_.width = _loc2_;
            _loc3_.width = _loc2_;
            _loc3_.x = _loc4_.right + 10;
            _loc4_.visible = true;
            _loc3_.visible = true;
         }
      }
      
      public function updatePart(param1:int, param2:IWindowController_1) : void
      {
         var _loc3_:IWindowModel = UnknownVarFromAvatarEditorGridView_IItemGridWindow_1.getGridItemAt(param1);
         if(!_loc3_)
         {
            return;
         }
         _loc3_ = param2;
      }
      
      private function onGridItemClicked(param1:WindowMouseEvent) : void
      {
         var _loc2_:int = 0;
         switch(param1.target.name)
         {
            case "REMOVE_ITEM":
               _loc2_ = UnknownVarFromAvatarEditorGridView_IItemGridWindow_1.getGridItemIndex(param1.window);
               UnknownVarFromAvatarEditorGridView_ICategoryBaseModel_1_1.selectPart(UnknownVarFromAvatarEditorGridView_String_1,_loc2_);
               break;
            case "GET_MORE":
               UnknownVarFromAvatarEditorGridView_ICategoryBaseModel_1_1.controller.manager.catalog.openCatalogPage(UnknownVarFromAvatarEditorGridView_ICategoryBaseModel_1_1.controller.manager.getProperty("catalog.clothes.page"));
               break;
            default:
               _loc2_ = UnknownVarFromAvatarEditorGridView_IItemGridWindow_1.getGridItemIndex(param1.window);
               UnknownVarFromAvatarEditorGridView_ICategoryBaseModel_1_1.selectPart(UnknownVarFromAvatarEditorGridView_String_1,_loc2_);
         }
      }
      
      private function paletteEventProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc5_:int = 0;
         var _loc4_:IItemGridWindow = null;
         var _loc7_:int = 0;
         var _loc3_:IWindowModel = null;
         var _loc6_:int = 0;
         if(param1.type == "WME_CLICK")
         {
            _loc3_ = param1.window;
            _loc6_ = 0;
            while(_loc6_ < 2)
            {
               if(UnknownVarFromAvatarEditorGridView_Array_1.length > _loc6_)
               {
                  _loc4_ = UnknownVarFromAvatarEditorGridView_Array_1[_loc6_] as IItemGridWindow;
                  _loc7_ = _loc4_.getGridItemIndex(_loc3_);
                  if(_loc7_ > -1)
                  {
                     UnknownVarFromAvatarEditorGridView_ICategoryBaseModel_1_1.selectColor(UnknownVarFromAvatarEditorGridView_String_1,_loc7_,_loc6_);
                     return;
                  }
               }
               _loc6_++;
            }
         }
      }
   }
}

