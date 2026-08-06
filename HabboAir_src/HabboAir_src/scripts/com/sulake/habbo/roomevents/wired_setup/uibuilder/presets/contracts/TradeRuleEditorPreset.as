package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.contracts
{
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IIconButtonWindow;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade.requirements.rules.TradeRequirementRule;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade.requirements.rules.nodes.TradeRequirementNode;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class TradeRuleEditorPreset extends WiredUIPreset
   {
      private static const NODE_VIEW_POOL_MAX_SIZE:int = 50;
      
      public static const MAX_NODES_IN_RULE:int = 5;
      
      public static const NODE_VIEW_POOL:Map = new Map();
      
      private var _container:IWindowModel;
      
      private var _nodeTemplate:IRegionWindow;
      
      private var UnknownVarFromTradeRuleEditorPreset_Vector_1:Vector.<TradeRuleNodeView>;
      
      private var UnknownVarFromTradeRuleEditorPreset_Function_1:Function;
      
      private var UnknownVarFromTradeRuleEditorPreset_Function_2:Function;
      
      private var UnknownVarFromTradeRuleEditorPreset_Function_3:Function;
      
      private var UnknownVarFromTradeRuleEditorPreset_Function_4:Function;
      
      private var UnknownVarFromTradeRuleEditorPreset_Boolean_1:Boolean = false;
      
      private var UnknownVarFromTradeRuleEditorPreset_Boolean_2:Boolean = false;
      
      public function TradeRuleEditorPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:String, param5:Function, param6:Function, param7:Function = null, param8:Function = null)
      {
         super(param1,param2,param3);
         _container = param3.createTradeRequirementRule();
         UnknownVarFromTradeRuleEditorPreset_Vector_1 = new Vector.<TradeRuleNodeView>();
         UnknownVarFromTradeRuleEditorPreset_Function_1 = param5;
         UnknownVarFromTradeRuleEditorPreset_Function_2 = param6;
         UnknownVarFromTradeRuleEditorPreset_Function_3 = param7;
         UnknownVarFromTradeRuleEditorPreset_Function_4 = param8;
         updateTitle(param4);
         var _loc9_:IItemGridWindow = itemGrid;
         _nodeTemplate = _loc9_.removeGridItemAt(0) as IRegionWindow;
         addMoreButton.addEventListener("WME_CLICK",onAddMoreClicked);
         _container.addEventListener("WME_OVER",onHover);
         _container.addEventListener("WME_OUT",onHoverEnd);
         closeRegion.addEventListener("WME_OVER",onCloseHover);
         closeRegion.addEventListener("WME_OUT",onCloseHoverEnd);
         closeRegion.addEventListener("WME_CLICK",onCloseClick);
         if(isOneLineMode)
         {
            _loc9_.setParamFlag(8388608,false);
         }
         updateCloseButtonVisibility();
      }
      
      protected function get isOneLineMode() : Boolean
      {
         return true;
      }
      
      protected function get showNodeCloseButton() : Boolean
      {
         return true;
      }
      
      public function set rule(param1:TradeRequirementRule) : void
      {
         removaAllNodes();
         for each(var _loc2_ in param1.nodes)
         {
            addNode(_loc2_);
         }
      }
      
      private function onAddMoreClicked(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromTradeRuleEditorPreset_Function_2 != null)
         {
            UnknownVarFromTradeRuleEditorPreset_Function_2(this);
         }
      }
      
      internal function editNode(param1:TradeRuleNodeView) : void
      {
         var _loc2_:int = itemGrid.getGridItemIndex(param1.window);
         if(_loc2_ == -1)
         {
            return;
         }
         var _loc3_:int = int(param1.uniqueID);
         if(UnknownVarFromTradeRuleEditorPreset_Function_1 != null)
         {
            UnknownVarFromTradeRuleEditorPreset_Function_1(this,_loc3_,param1.node);
         }
      }
      
      public function updateTitle(param1:String) : void
      {
         titleWindow.text = param1;
      }
      
      private function fireOnChange() : void
      {
         if(UnknownVarFromTradeRuleEditorPreset_Function_4 != null)
         {
            UnknownVarFromTradeRuleEditorPreset_Function_4();
         }
      }
      
      public function addNode(param1:TradeRequirementNode) : void
      {
         if(disposed)
         {
            return;
         }
         var _loc3_:IItemGridWindow = itemGrid;
         var _loc2_:TradeRuleNodeView = createNodeView(param1.deepCopy(),showNodeCloseButton);
         _loc3_.addGridItemAt(_loc2_.window,_loc3_.numGridItems - 1);
         UnknownVarFromTradeRuleEditorPreset_Vector_1.push(_loc2_);
         onNodeCountChange();
      }
      
      private function createNodeView(param1:TradeRequirementNode, param2:Boolean = true) : TradeRuleNodeView
      {
         var _loc3_:TradeRuleNodeView = null;
         var _loc4_:WiredStyle = UnknownVarFromWiredUIPreset_WiredStyle_1;
         if(!NODE_VIEW_POOL.hasKey(_loc4_.name))
         {
            NODE_VIEW_POOL.add(_loc4_.name,new Vector.<TradeRuleNodeView>());
         }
         var _loc5_:Vector.<TradeRuleNodeView> = NODE_VIEW_POOL.getValue(_loc4_.name);
         if(_loc5_.length > 0)
         {
            _loc3_ = _loc5_.pop();
         }
         else
         {
            _loc3_ = new TradeRuleNodeView(nodeTemplate);
         }
         _loc3_.initialize(this,param1,param2);
         return _loc3_;
      }
      
      private function releaseNodeView(param1:TradeRuleNodeView) : void
      {
         var _loc2_:WiredStyle = UnknownVarFromWiredUIPreset_WiredStyle_1;
         if(!NODE_VIEW_POOL.hasKey(_loc2_.name))
         {
            NODE_VIEW_POOL.add(_loc2_.name,new Vector.<TradeRuleNodeView>());
         }
         var _loc3_:Vector.<TradeRuleNodeView> = NODE_VIEW_POOL.getValue(_loc2_.name);
         if(_loc3_.length >= 50)
         {
            param1.dispose();
         }
         else
         {
            param1.release();
            _loc3_.push(param1);
         }
      }
      
      public function updateNode(param1:uint, param2:TradeRequirementNode) : void
      {
         if(disposed)
         {
            return;
         }
         var _loc3_:TradeRuleNodeView = getNodeViewByUniqueId(param1);
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.node = param2;
         fireOnChange();
      }
      
      public function finalizeRule() : TradeRequirementRule
      {
         var _loc2_:Vector.<TradeRequirementNode> = new Vector.<TradeRequirementNode>();
         for each(var _loc1_ in UnknownVarFromTradeRuleEditorPreset_Vector_1)
         {
            _loc2_.push(_loc1_.node);
         }
         return new TradeRequirementRule(_loc2_);
      }
      
      private function getNodeViewByUniqueId(param1:uint) : TradeRuleNodeView
      {
         for each(var _loc2_ in UnknownVarFromTradeRuleEditorPreset_Vector_1)
         {
            if(_loc2_.uniqueID == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      internal function removeNode(param1:TradeRuleNodeView) : void
      {
         var _loc2_:int = int(UnknownVarFromTradeRuleEditorPreset_Vector_1.indexOf(param1));
         if(_loc2_ == -1)
         {
            return;
         }
         UnknownVarFromTradeRuleEditorPreset_Vector_1.removeAt(_loc2_);
         itemGrid.removeGridItem(param1.window);
         releaseNodeView(param1);
         onNodeCountChange();
      }
      
      private function removaAllNodes() : void
      {
         if(addMoreButton != null)
         {
            while(itemGrid.numGridItems > 1)
            {
               itemGrid.removeGridItemAt(0);
            }
         }
         else
         {
            itemGrid.removeGridItems();
         }
         for each(var _loc1_ in UnknownVarFromTradeRuleEditorPreset_Vector_1)
         {
            releaseNodeView(_loc1_);
         }
         UnknownVarFromTradeRuleEditorPreset_Vector_1 = new Vector.<TradeRuleNodeView>();
         onNodeCountChange();
      }
      
      protected function onNodeCountChange() : void
      {
         itemGrid.rebuildGridStructure();
         if(addMoreButton != null)
         {
            if(isOneLineMode)
            {
               addMoreButton.visible = UnknownVarFromTradeRuleEditorPreset_Vector_1.length < 5;
            }
            else
            {
               Util.disableSection(addMoreButton,UnknownVarFromTradeRuleEditorPreset_Vector_1.length >= 5);
            }
         }
         fireOnChange();
      }
      
      private function onCloseClick(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromTradeRuleEditorPreset_Function_3 != null)
         {
            UnknownVarFromTradeRuleEditorPreset_Function_3(this);
         }
      }
      
      private function onHoverEnd(param1:WindowMouseEvent) : void
      {
         UnknownVarFromTradeRuleEditorPreset_Boolean_1 = false;
         updateCloseButtonVisibility();
      }
      
      private function onHover(param1:WindowMouseEvent) : void
      {
         UnknownVarFromTradeRuleEditorPreset_Boolean_1 = true;
         updateCloseButtonVisibility();
      }
      
      private function onCloseHoverEnd(param1:WindowMouseEvent) : void
      {
         UnknownVarFromTradeRuleEditorPreset_Boolean_2 = false;
         updateCloseButtonVisibility();
      }
      
      private function onCloseHover(param1:WindowMouseEvent) : void
      {
         UnknownVarFromTradeRuleEditorPreset_Boolean_2 = true;
         updateCloseButtonVisibility();
      }
      
      protected function updateCloseButtonVisibility() : void
      {
         closeRegion.visible = (UnknownVarFromTradeRuleEditorPreset_Boolean_1 || UnknownVarFromTradeRuleEditorPreset_Boolean_2) && UnknownVarFromTradeRuleEditorPreset_Function_3 != null;
      }
      
      internal function get nodeTemplate() : IRegionWindow
      {
         return _nodeTemplate;
      }
      
      override public function get window() : IWindowModel
      {
         return _container;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         _container.width = param1;
      }
      
      override protected function get childPresets() : Array
      {
         return [];
      }
      
      override public function dispose() : void
      {
         removaAllNodes();
         if(disposed)
         {
            return;
         }
         super.dispose();
         UnknownVarFromTradeRuleEditorPreset_Vector_1 = null;
         UnknownVarFromTradeRuleEditorPreset_Function_1 = null;
         UnknownVarFromTradeRuleEditorPreset_Function_2 = null;
         UnknownVarFromTradeRuleEditorPreset_Function_3 = null;
         _nodeTemplate.dispose();
         _nodeTemplate = null;
         _container.dispose();
         _container = null;
      }
      
      protected function get itemGrid() : IItemGridWindow
      {
         return _container.findChildByName("grid") as IItemGridWindow;
      }
      
      protected function get titleWindow() : ITextWindow
      {
         return _container.findChildByName("title") as ITextWindow;
      }
      
      protected function get addMoreContainer() : IWindowController_1
      {
         return _container.findChildByName("add_more_container") as IWindowController_1;
      }
      
      protected function get addMoreButton() : IIconButtonWindow
      {
         return _container.findChildByName("add_more") as IIconButtonWindow;
      }
      
      protected function get closeRegion() : IRegionWindow
      {
         return _container.findChildByName("close_rule_region") as IRegionWindow;
      }
   }
}

