package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.AssetButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class AssetButtonRowPreset extends WiredUIPreset
   {
      private var _container:IWindowController_1;
      
      private var UnknownVarFromAssetButtonRowPreset_SimpleListViewPreset_1:SimpleListViewPreset;
      
      private var _buttons:Vector.<AssetButtonPreset>;
      
      private var UnknownVarFromAssetButtonRowPreset_Array_1:Array;
      
      public function AssetButtonRowPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:Array)
      {
         var _loc5_:AssetButtonPreset = null;
         var _loc6_:int = 0;
         super(param1,param2,param3);
         _buttons = new Vector.<AssetButtonPreset>();
         UnknownVarFromAssetButtonRowPreset_Array_1 = [];
         for each(var _loc7_ in param4)
         {
            _loc5_ = param2.createAssetButtonPreset(_loc7_.assetName,_loc7_.tooltip,_loc7_.onClick);
            _buttons.push(_loc5_);
            if(_loc7_.alignRight)
            {
               UnknownVarFromAssetButtonRowPreset_Array_1.push(_loc5_.alignRight());
            }
            else
            {
               UnknownVarFromAssetButtonRowPreset_Array_1.push(_loc5_);
            }
            if(_loc7_.isFollowedBySplitter)
            {
               _loc6_ = _loc5_.window.height;
               if(_loc6_ == 0)
               {
                  throw new Error("AssetButtonRowPreset requires button height to resolve splitter height");
               }
               UnknownVarFromAssetButtonRowPreset_Array_1.push(new VerticalSplitterPreset(param1,param2,param3,_loc6_));
            }
         }
         UnknownVarFromAssetButtonRowPreset_SimpleListViewPreset_1 = param2.createSimpleListView(false,UnknownVarFromAssetButtonRowPreset_Array_1);
         UnknownVarFromAssetButtonRowPreset_SimpleListViewPreset_1.spacing = param3.genericHorizontalSpacing;
         _container = param2.createLayout("growing_container_view") as IWindowController_1;
         _container.addChild(UnknownVarFromAssetButtonRowPreset_SimpleListViewPreset_1.window);
      }
      
      public function get buttons() : Vector.<AssetButtonPreset>
      {
         return _buttons;
      }
      
      override public function get window() : IWindowModel
      {
         return _container;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         UnknownVarFromAssetButtonRowPreset_SimpleListViewPreset_1.resizeToWidth(param1);
         _container.width = UnknownVarFromAssetButtonRowPreset_SimpleListViewPreset_1.window.width;
         _container.height = UnknownVarFromAssetButtonRowPreset_SimpleListViewPreset_1.window.height;
      }
      
      override protected function get childPresets() : Array
      {
         return [UnknownVarFromAssetButtonRowPreset_SimpleListViewPreset_1];
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         _container.dispose();
         _container = null;
         UnknownVarFromAssetButtonRowPreset_SimpleListViewPreset_1 = null;
         _buttons = null;
         UnknownVarFromAssetButtonRowPreset_Array_1 = null;
      }
   }
}

