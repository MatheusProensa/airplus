package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.combinations
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SimpleListViewPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class RewardListPreset extends WiredUIPreset
   {
      private var _container:IItemListWindow;
      
      private var UnknownVarFromRewardListPreset_IItemListWindow_1:IItemListWindow;
      
      private var UnknownVarFromRewardListPreset_SimpleListViewPreset_1:SimpleListViewPreset;
      
      private var UnknownVarFromRewardListPreset_TextPreset_1:TextPreset;
      
      private var UnknownVarFromRewardListPreset_Vector_1:Vector.<RewardRowPreset>;
      
      private var _displayedRewards:int;
      
      private var _maxRewards:int;
      
      private var UnknownVarFromRewardListPreset_Boolean_1:Boolean = true;
      
      private var _expectedWidth:int = 0;
      
      public function RewardListPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:int, param5:int)
      {
         var _loc8_:int = 0;
         var _loc9_:RewardRowPreset = null;
         super(param1,param2,param3);
         _maxRewards = param4;
         _container = param2.createLayout("vertical_list_view") as IItemListWindow;
         _container.spacing = param3.genericVerticalSpacing;
         var _loc6_:TextPreset = param2.createText("Badge?",new TextParam(0,false));
         var _loc7_:TextPreset = param2.createText("Product/Badge code",new TextParam(2,false));
         UnknownVarFromRewardListPreset_TextPreset_1 = param2.createText("Probability",new TextParam(0,false));
         UnknownVarFromRewardListPreset_SimpleListViewPreset_1 = param2.createSimpleListView(false,[_loc6_,_loc7_,UnknownVarFromRewardListPreset_TextPreset_1]);
         UnknownVarFromRewardListPreset_IItemListWindow_1 = param2.createLayout("vertical_list_view") as IItemListWindow;
         UnknownVarFromRewardListPreset_IItemListWindow_1.spacing = param3.genericVerticalSpacing;
         UnknownVarFromRewardListPreset_Vector_1 = new Vector.<RewardRowPreset>();
         _loc8_ = 0;
         while(_loc8_ < _maxRewards)
         {
            _loc9_ = param2.createRewardRow();
            UnknownVarFromRewardListPreset_Vector_1.push(_loc9_);
            _loc8_++;
         }
         _container.addListItem(UnknownVarFromRewardListPreset_SimpleListViewPreset_1.window);
         _container.addListItem(UnknownVarFromRewardListPreset_IItemListWindow_1);
         setDisplayedRewards(param5);
         _displayedRewards = param5;
      }
      
      public function setDisplayedRewards(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = Math.max(0,Math.min(_maxRewards,param1));
         if(_loc2_ == _displayedRewards)
         {
            return;
         }
         if(_loc2_ > _displayedRewards)
         {
            _loc3_ = _displayedRewards;
            while(_loc3_ < _loc2_)
            {
               UnknownVarFromRewardListPreset_IItemListWindow_1.addListItem(UnknownVarFromRewardListPreset_Vector_1[_loc3_].window);
               if(_expectedWidth > 0)
               {
                  UnknownVarFromRewardListPreset_Vector_1[_loc3_].resizeToWidth(_expectedWidth);
               }
               _loc3_++;
            }
         }
         else
         {
            _loc3_ = _displayedRewards - 1;
            while(_loc3_ >= _loc2_)
            {
               UnknownVarFromRewardListPreset_IItemListWindow_1.removeListItem(UnknownVarFromRewardListPreset_Vector_1[_loc3_].window);
               _loc3_--;
            }
         }
         _displayedRewards = _loc2_;
      }
      
      public function get displayedRewards() : int
      {
         return _displayedRewards;
      }
      
      public function getRow(param1:int) : RewardRowPreset
      {
         return UnknownVarFromRewardListPreset_Vector_1[param1];
      }
      
      public function setProbabilityEnabled(param1:Boolean) : void
      {
         if(UnknownVarFromRewardListPreset_Boolean_1 == param1)
         {
            return;
         }
         UnknownVarFromRewardListPreset_Boolean_1 = param1;
         UnknownVarFromRewardListPreset_TextPreset_1.disabled = !param1;
         for each(var _loc2_ in UnknownVarFromRewardListPreset_Vector_1)
         {
            _loc2_.setProbabilityVisible(param1);
         }
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         var _loc2_:int = 0;
         super.resizeToWidth(param1);
         _expectedWidth = param1;
         _container.width = param1;
         UnknownVarFromRewardListPreset_SimpleListViewPreset_1.resizeToWidth(param1);
         UnknownVarFromRewardListPreset_IItemListWindow_1.width = param1;
         _loc2_ = 0;
         while(_loc2_ < _displayedRewards)
         {
            UnknownVarFromRewardListPreset_Vector_1[_loc2_].resizeToWidth(param1);
            _loc2_++;
         }
      }
      
      override public function get window() : IWindowModel
      {
         return _container;
      }
      
      override protected function get childPresets() : Array
      {
         var _loc1_:Array = [UnknownVarFromRewardListPreset_SimpleListViewPreset_1];
         for each(var _loc2_ in UnknownVarFromRewardListPreset_Vector_1)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
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
         UnknownVarFromRewardListPreset_SimpleListViewPreset_1 = null;
         UnknownVarFromRewardListPreset_IItemListWindow_1 = null;
         UnknownVarFromRewardListPreset_TextPreset_1 = null;
         UnknownVarFromRewardListPreset_Vector_1 = null;
      }
   }
}

