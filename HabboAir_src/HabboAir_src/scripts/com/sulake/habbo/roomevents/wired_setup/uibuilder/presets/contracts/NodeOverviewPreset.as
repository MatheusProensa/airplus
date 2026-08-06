package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.contracts
{
   import com.sulake.core.window.components.IIconButtonWindow;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class NodeOverviewPreset extends TradeRuleEditorPreset
   {
      private var UnknownVarFromNodeOverviewPreset_Function_1:Function = null;
      
      public function NodeOverviewPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:String, param5:Function = null)
      {
         super(param1,param2,param3,param4,null,null);
         var _loc6_:IIconButtonWindow = addMoreButton;
         _loc6_.parent = null;
         _loc6_.dispose();
         closeRegion.visible = false;
         UnknownVarFromNodeOverviewPreset_Function_1 = param5;
      }
      
      override protected function get isOneLineMode() : Boolean
      {
         return false;
      }
      
      override protected function get showNodeCloseButton() : Boolean
      {
         return false;
      }
      
      override protected function updateCloseButtonVisibility() : void
      {
      }
      
      override internal function editNode(param1:TradeRuleNodeView) : void
      {
         if(UnknownVarFromNodeOverviewPreset_Function_1 != null)
         {
            UnknownVarFromNodeOverviewPreset_Function_1(param1.node);
         }
      }
   }
}

