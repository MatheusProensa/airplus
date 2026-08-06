package com.sulake.habbo.groups
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.runtime.exceptions.Exception;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.users.GuildColorData;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   
   public class ColorGridCtrl
   {
      private var UnknownVarFromColorGridCtrl_HabboGroupsManager_1:HabboGroupsManager;
      
      private var UnknownVarFromColorGridCtrl_IWindowController_1_1:IWindowController_1;
      
      private var _parentCallback:Function;
      
      private var UnknownVarFromColorGridCtrl_Vector_1:Vector.<GuildColorData>;
      
      private var UnknownVarFromColorGridCtrl_IItemGridWindow_1:IItemGridWindow;
      
      private var _selectedColorIndex:int = -1;
      
      private var UnknownVarFromColorGridCtrl_BitmapData_1:BitmapData;
      
      private var UnknownVarFromColorGridCtrl_BitmapData_2:BitmapData;
      
      private var UnknownVarFromColorGridCtrl_BitmapData_3:BitmapData;
      
      private var _disposed:Boolean = false;
      
      public function ColorGridCtrl(param1:HabboGroupsManager, param2:Function)
      {
         super();
         UnknownVarFromColorGridCtrl_HabboGroupsManager_1 = param1;
         _parentCallback = param2;
      }
      
      public function get selectedColorIndex() : int
      {
         return _selectedColorIndex;
      }
      
      public function get isInitialized() : Boolean
      {
         return UnknownVarFromColorGridCtrl_Vector_1 != null && UnknownVarFromColorGridCtrl_IItemGridWindow_1 != null;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(UnknownVarFromColorGridCtrl_IItemGridWindow_1)
            {
               UnknownVarFromColorGridCtrl_IItemGridWindow_1.destroyGridItems();
               UnknownVarFromColorGridCtrl_IItemGridWindow_1 = null;
            }
            if(UnknownVarFromColorGridCtrl_BitmapData_2)
            {
               UnknownVarFromColorGridCtrl_BitmapData_2.dispose();
               UnknownVarFromColorGridCtrl_BitmapData_2 = null;
            }
            if(UnknownVarFromColorGridCtrl_BitmapData_3)
            {
               UnknownVarFromColorGridCtrl_BitmapData_3.dispose();
               UnknownVarFromColorGridCtrl_BitmapData_3 = null;
            }
            if(UnknownVarFromColorGridCtrl_BitmapData_2)
            {
               UnknownVarFromColorGridCtrl_BitmapData_2.dispose();
               UnknownVarFromColorGridCtrl_BitmapData_2 = null;
            }
            if(UnknownVarFromColorGridCtrl_BitmapData_1)
            {
               UnknownVarFromColorGridCtrl_BitmapData_1.dispose();
               UnknownVarFromColorGridCtrl_BitmapData_1 = null;
            }
            UnknownVarFromColorGridCtrl_HabboGroupsManager_1 = null;
            UnknownVarFromColorGridCtrl_IWindowController_1_1 = null;
            _disposed = true;
         }
      }
      
      public function createAndAttach(param1:IWindowController_1, param2:String, param3:Vector.<GuildColorData>) : void
      {
         var _loc4_:IWindowController_1 = null;
         if(UnknownVarFromColorGridCtrl_IItemGridWindow_1 != null || param1 == null || param2 == null || param3 == null)
         {
            return;
         }
         UnknownVarFromColorGridCtrl_IWindowController_1_1 = param1;
         UnknownVarFromColorGridCtrl_Vector_1 = param3;
         UnknownVarFromColorGridCtrl_IItemGridWindow_1 = UnknownVarFromColorGridCtrl_IWindowController_1_1.findChildByName(param2) as IItemGridWindow;
         UnknownVarFromColorGridCtrl_BitmapData_2 = getBitmap("color_chooser_bg");
         UnknownVarFromColorGridCtrl_BitmapData_3 = getBitmap("color_chooser_fg");
         UnknownVarFromColorGridCtrl_BitmapData_1 = getBitmap("color_chooser_selected");
         for each(var _loc5_ in UnknownVarFromColorGridCtrl_Vector_1)
         {
            _loc4_ = UnknownVarFromColorGridCtrl_HabboGroupsManager_1.getXmlWindow("badge_color_item") as IWindowController_1;
            _loc4_.procedure = onClick;
            _loc4_.background = true;
            _loc4_.color = 4290689957;
            _loc4_.width = UnknownVarFromColorGridCtrl_BitmapData_2.width;
            _loc4_.height = UnknownVarFromColorGridCtrl_BitmapData_2.height;
            setGridItemBitmap(_loc4_,"background",UnknownVarFromColorGridCtrl_BitmapData_2,true,null);
            setGridItemBitmap(_loc4_,"foreground",UnknownVarFromColorGridCtrl_BitmapData_3,true,_loc5_);
            setGridItemBitmap(_loc4_,"selected",UnknownVarFromColorGridCtrl_BitmapData_1,false,null);
            UnknownVarFromColorGridCtrl_IItemGridWindow_1.addGridItem(_loc4_);
         }
      }
      
      private function setGridItemBitmap(param1:IWindowController_1, param2:String, param3:BitmapData, param4:Boolean, param5:GuildColorData = null) : void
      {
         var _loc7_:BitmapData = null;
         var _loc6_:IBitmapWrapperController = param1.findChildByName(param2) as IBitmapWrapperController;
         if(_loc6_ != null)
         {
            _loc7_ = param3.clone();
            if(param5 != null)
            {
               _loc7_.colorTransform(_loc7_.rect,new ColorTransform(param5.red / 255,param5.green / 255,param5.blue / 255));
            }
            _loc6_.bitmap = _loc7_;
            _loc6_.visible = param4;
         }
      }
      
      public function setSelectedColorIndex(param1:int, param2:Boolean = true) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(_selectedColorIndex != param1 && param1 < UnknownVarFromColorGridCtrl_IItemGridWindow_1.numGridItems)
         {
            setSelectedItemVisibility(_selectedColorIndex,false);
            _selectedColorIndex = param1;
            setSelectedItemVisibility(_selectedColorIndex,true);
         }
         if(param2 && _parentCallback != null)
         {
            _parentCallback(this);
         }
      }
      
      public function setSelectedColorById(param1:int) : void
      {
         var _loc2_:int = 0;
         if(!isInitialized)
         {
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < UnknownVarFromColorGridCtrl_Vector_1.length)
         {
            if(UnknownVarFromColorGridCtrl_Vector_1[_loc2_].id == param1)
            {
               setSelectedColorIndex(_loc2_);
               return;
            }
            _loc2_++;
         }
         setSelectedColorIndex(0);
      }
      
      public function getSelectedColorId() : int
      {
         var _loc1_:GuildColorData = getSelectedColorData();
         if(_loc1_ != null)
         {
            return _loc1_.id;
         }
         return 0;
      }
      
      public function getSelectedColorData() : GuildColorData
      {
         if(UnknownVarFromColorGridCtrl_Vector_1 != null && _selectedColorIndex >= 0 && _selectedColorIndex < UnknownVarFromColorGridCtrl_Vector_1.length)
         {
            return UnknownVarFromColorGridCtrl_Vector_1[_selectedColorIndex];
         }
         return null;
      }
      
      private function getBitmap(param1:String) : BitmapData
      {
         var _loc3_:BitmapData = null;
         var _loc2_:BitmapDataAsset = UnknownVarFromColorGridCtrl_HabboGroupsManager_1.assets.getAssetByName(param1) as BitmapDataAsset;
         if(_loc2_)
         {
            _loc3_ = _loc2_.content as BitmapData;
            if(_loc3_ != null)
            {
               return _loc3_;
            }
         }
         throw new Exception("Failed to load bitmap asset " + param1 + " in ColorGridWidget");
      }
      
      private function setSelectedItemVisibility(param1:int, param2:Boolean) : void
      {
         var _loc3_:IWindowModel = null;
         if(param1 < 0 || param1 >= UnknownVarFromColorGridCtrl_IItemGridWindow_1.numGridItems)
         {
            return;
         }
         var _loc4_:IWindowController_1 = UnknownVarFromColorGridCtrl_IItemGridWindow_1.getGridItemAt(param1) as IWindowController_1;
         if(_loc4_ != null)
         {
            _loc3_ = _loc4_.findChildByName("selected") as IWindowModel;
            if(_loc3_ != null)
            {
               _loc3_.visible = param2;
            }
         }
      }
      
      private function onClick(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         setSelectedColorIndex(UnknownVarFromColorGridCtrl_IItemGridWindow_1.getGridItemIndex(param2));
      }
   }
}

