package com.sulake.habbo.groups.badge
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.groups.ColorGridCtrl;
   import com.sulake.habbo.groups.HabboGroupsManager;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class BadgeLayerCtrl
   {
      public static var BASE_LAYER_INDEX:int = 0;
      
      public static var PARENT_CONTAINER_NAME:String = "part_edit_list";
      
      private var UnknownVarFromBadgeLayerCtrl_HabboGroupsManager_1:HabboGroupsManager;
      
      private var UnknownVarFromBadgeLayerCtrl_BadgeEditorCtrl_1:BadgeEditorCtrl;
      
      private var UnknownVarFromBadgeLayerCtrl_Int_1:int = 0;
      
      private var _layerOptions:BadgeLayerOptions;
      
      private var UnknownVarFromBadgeLayerCtrl_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromBadgeLayerCtrl_ColorGridCtrl_1:ColorGridCtrl;
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromBadgeLayerCtrl_BitmapData_1:BitmapData;
      
      private var UnknownVarFromBadgeLayerCtrl_IBitmapWrapperController_1:IBitmapWrapperController;
      
      private var UnknownVarFromBadgeLayerCtrl_UnknownICoreWindowComponents4_1:UnknownICoreWindowComponents4;
      
      private var UnknownVarFromBadgeLayerCtrl_IWindowController_1_2:IWindowController_1;
      
      private var UnknownVarFromBadgeLayerCtrl_IBitmapWrapperController_2:IBitmapWrapperController;
      
      private var UnknownVarFromBadgeLayerCtrl_IBitmapWrapperController_3:IBitmapWrapperController;
      
      public function BadgeLayerCtrl(param1:HabboGroupsManager, param2:BadgeEditorCtrl, param3:int)
      {
         super();
         UnknownVarFromBadgeLayerCtrl_HabboGroupsManager_1 = param1;
         UnknownVarFromBadgeLayerCtrl_BadgeEditorCtrl_1 = param2;
         UnknownVarFromBadgeLayerCtrl_Int_1 = param3;
         _layerOptions = new BadgeLayerOptions();
         _layerOptions.layerIndex = param3;
         UnknownVarFromBadgeLayerCtrl_BitmapData_1 = UnknownVarFromBadgeLayerCtrl_HabboGroupsManager_1.getButtonImage("badge_part_add");
      }
      
      public function createWindow() : void
      {
         if(UnknownVarFromBadgeLayerCtrl_IWindowController_1_1 != null)
         {
            return;
         }
         var _loc1_:IItemListWindow = UnknownVarFromBadgeLayerCtrl_BadgeEditorCtrl_1.partEditContainer.findChildByName(PARENT_CONTAINER_NAME) as IItemListWindow;
         UnknownVarFromBadgeLayerCtrl_IWindowController_1_1 = UnknownVarFromBadgeLayerCtrl_HabboGroupsManager_1.getXmlWindow("badge_layer") as IWindowController_1;
         var _loc2_:IWindowController_1 = UnknownVarFromBadgeLayerCtrl_IWindowController_1_1.findChildByName("preview_container") as IWindowController_1;
         UnknownVarFromBadgeLayerCtrl_IBitmapWrapperController_1 = _loc2_.findChildByName("part_preview") as IBitmapWrapperController;
         UnknownVarFromBadgeLayerCtrl_IBitmapWrapperController_1.bitmap = UnknownVarFromBadgeLayerCtrl_HabboGroupsManager_1.getButtonImage("badge_part_add");
         UnknownVarFromBadgeLayerCtrl_UnknownICoreWindowComponents4_1 = _loc2_.findChildByName("part_button") as UnknownICoreWindowComponents4;
         UnknownVarFromBadgeLayerCtrl_UnknownICoreWindowComponents4_1.procedure = onPartPreviewButtonClick;
         UnknownVarFromBadgeLayerCtrl_IWindowController_1_2 = UnknownVarFromBadgeLayerCtrl_IWindowController_1_1.findChildByName("position_container") as IWindowController_1;
         UnknownVarFromBadgeLayerCtrl_IBitmapWrapperController_2 = UnknownVarFromBadgeLayerCtrl_IWindowController_1_2.findChildByName("position_picker") as IBitmapWrapperController;
         UnknownVarFromBadgeLayerCtrl_IBitmapWrapperController_2.bitmap = UnknownVarFromBadgeLayerCtrl_HabboGroupsManager_1.getButtonImage("position_picker");
         UnknownVarFromBadgeLayerCtrl_IBitmapWrapperController_3 = UnknownVarFromBadgeLayerCtrl_IWindowController_1_2.findChildByName("position_grid") as IBitmapWrapperController;
         UnknownVarFromBadgeLayerCtrl_IBitmapWrapperController_3.bitmap = UnknownVarFromBadgeLayerCtrl_HabboGroupsManager_1.getButtonImage("position_grid");
         if(UnknownVarFromBadgeLayerCtrl_Int_1 == 0)
         {
            UnknownVarFromBadgeLayerCtrl_IBitmapWrapperController_3.visible = false;
            UnknownVarFromBadgeLayerCtrl_IBitmapWrapperController_2.visible = false;
         }
         else
         {
            UnknownVarFromBadgeLayerCtrl_IBitmapWrapperController_3.procedure = onPositionGridClick;
         }
         UnknownVarFromBadgeLayerCtrl_ColorGridCtrl_1 = new ColorGridCtrl(UnknownVarFromBadgeLayerCtrl_HabboGroupsManager_1,onColorSelected);
         UnknownVarFromBadgeLayerCtrl_ColorGridCtrl_1.createAndAttach(UnknownVarFromBadgeLayerCtrl_IWindowController_1_1,"color_selector",UnknownVarFromBadgeLayerCtrl_HabboGroupsManager_1.guildEditorData.badgeColors);
         if(_layerOptions.layerIndex == BASE_LAYER_INDEX)
         {
            _loc1_.addListItem(UnknownVarFromBadgeLayerCtrl_IWindowController_1_1);
         }
         else
         {
            _loc1_.addListItemAt(UnknownVarFromBadgeLayerCtrl_IWindowController_1_1,0);
         }
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(UnknownVarFromBadgeLayerCtrl_ColorGridCtrl_1)
            {
               UnknownVarFromBadgeLayerCtrl_ColorGridCtrl_1.dispose();
               UnknownVarFromBadgeLayerCtrl_ColorGridCtrl_1 = null;
            }
            if(UnknownVarFromBadgeLayerCtrl_IWindowController_1_1)
            {
               UnknownVarFromBadgeLayerCtrl_IWindowController_1_1.dispose();
               UnknownVarFromBadgeLayerCtrl_IWindowController_1_1 = null;
            }
            UnknownVarFromBadgeLayerCtrl_IBitmapWrapperController_1 = null;
            UnknownVarFromBadgeLayerCtrl_UnknownICoreWindowComponents4_1 = null;
            UnknownVarFromBadgeLayerCtrl_IWindowController_1_2 = null;
            UnknownVarFromBadgeLayerCtrl_IBitmapWrapperController_2 = null;
            UnknownVarFromBadgeLayerCtrl_IBitmapWrapperController_3 = null;
            UnknownVarFromBadgeLayerCtrl_HabboGroupsManager_1 = null;
            _disposed = true;
         }
      }
      
      public function setLayerOptions(param1:BadgeLayerOptions) : void
      {
         if(param1.layerIndex != _layerOptions.layerIndex)
         {
            throw new Error("Tried to set layer option with invalid layerIndex value");
         }
         var _loc2_:Boolean = false;
         var _loc3_:BadgeLayerOptions = _layerOptions;
         _layerOptions = param1.clone();
         if(!_layerOptions.isGridEqual(_loc3_))
         {
            updatePositionPicker(false);
            _loc2_ = true;
         }
         if(_loc3_.colorIndex != _layerOptions.colorIndex)
         {
            UnknownVarFromBadgeLayerCtrl_ColorGridCtrl_1.setSelectedColorIndex(_layerOptions.colorIndex,false);
            _layerOptions.colorIndex = UnknownVarFromBadgeLayerCtrl_ColorGridCtrl_1.selectedColorIndex;
            _loc2_ = true;
         }
         if(_loc2_ || _loc3_.partIndex != _layerOptions.partIndex)
         {
            updateSelectedPart();
         }
      }
      
      public function get layerOptions() : BadgeLayerOptions
      {
         return _layerOptions;
      }
      
      public function updateSelectedPart() : void
      {
         var _loc1_:BitmapData = null;
         if(UnknownVarFromBadgeLayerCtrl_BadgeEditorCtrl_1.badgeSelectPartCtrl)
         {
            _loc1_ = UnknownVarFromBadgeLayerCtrl_BadgeEditorCtrl_1.badgeSelectPartCtrl.getPartItemImage(layerOptions);
         }
         if(_loc1_ == null)
         {
            _loc1_ = UnknownVarFromBadgeLayerCtrl_BitmapData_1;
         }
         UnknownVarFromBadgeLayerCtrl_IBitmapWrapperController_1.bitmap.dispose();
         UnknownVarFromBadgeLayerCtrl_IBitmapWrapperController_1.bitmap = new BitmapData(_loc1_.width,_loc1_.height);
         UnknownVarFromBadgeLayerCtrl_IBitmapWrapperController_1.bitmap.copyPixels(_loc1_,_loc1_.rect,new Point());
         UnknownVarFromBadgeLayerCtrl_BadgeEditorCtrl_1.onPartChanged(this);
      }
      
      private function updatePositionPicker(param1:Boolean = true) : void
      {
         UnknownVarFromBadgeLayerCtrl_IBitmapWrapperController_2.x = _layerOptions.gridX * 14 + 1;
         UnknownVarFromBadgeLayerCtrl_IBitmapWrapperController_2.y = _layerOptions.gridY * 14 + 1;
         if(param1)
         {
            updateSelectedPart();
         }
      }
      
      private function onPositionGridClick(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK" || !UnknownVarFromBadgeLayerCtrl_IBitmapWrapperController_2)
         {
            return;
         }
         var _loc3_:WindowMouseEvent = param1 as WindowMouseEvent;
         _layerOptions.gridX = Math.min(2,Math.max(0,Math.floor(_loc3_.localX / 14)));
         _layerOptions.gridY = Math.min(2,Math.max(0,Math.floor(_loc3_.localY / 14)));
         updatePositionPicker();
      }
      
      private function onPartPreviewButtonClick(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         UnknownVarFromBadgeLayerCtrl_BadgeEditorCtrl_1.onShowSelectPart(this);
      }
      
      public function onColorSelected(param1:ColorGridCtrl) : void
      {
         if(_layerOptions.colorIndex != param1.selectedColorIndex)
         {
            _layerOptions.colorIndex = param1.selectedColorIndex;
            updateSelectedPart();
         }
      }
   }
}

