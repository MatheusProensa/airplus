package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.SectionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class SectionPreset extends WiredUIPreset
   {
      private var _container:IItemListWindow;
      
      private var UnknownVarFromSectionPreset_IItemListWindow_1:IItemListWindow;
      
      private var _headerContainer:IWindowController_1;
      
      private var _headerOptionsRightList:IItemListWindow;
      
      private var _headerLeft:IItemListWindow;
      
      private var _expectedWidth:int;
      
      private var _splitter:SplitterPreset;
      
      private var UnknownVarFromSectionPreset_TextPreset_1:TextPreset;
      
      private var _headerOptionsRight:Vector.<WiredUIPreset>;
      
      private var UnknownVarFromSectionPreset_WiredUIPreset_1:WiredUIPreset;
      
      private var _headerOptionLeft:WiredUIPreset;
      
      public function SectionPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:String, param5:WiredUIPreset, param6:SectionParam = null)
      {
         var _loc8_:SourceTypeSelectorPreset = null;
         var _loc9_:CollapseExpandSectionButtonPreset = null;
         super(param1,param2,param3);
         if(param6 == null)
         {
            param6 = SectionParam.DEFAULT;
         }
         _container = param2.createLayout("vertical_list_view") as IItemListWindow;
         UnknownVarFromSectionPreset_IItemListWindow_1 = param2.createLayout("vertical_list_view") as IItemListWindow;
         _container.spacing = param3.sectionSpacing;
         UnknownVarFromSectionPreset_IItemListWindow_1.spacing = param3.sectionSpacing;
         UnknownVarFromSectionPreset_IItemListWindow_1.x = param3.sectionLeftRightMargin;
         _headerOptionsRight = new Vector.<WiredUIPreset>();
         _headerContainer = param2.createLayout("container_view") as IWindowController_1;
         _headerLeft = param2.createLayout("horizontal_list_view") as IItemListWindow;
         _headerLeft.spacing = param3.genericHorizontalSpacing;
         _headerOptionsRightList = param2.createLayout("horizontal_list_view") as IItemListWindow;
         _headerOptionsRightList.spacing = param3.genericHorizontalSpacing;
         _splitter = param2.createSplitter();
         UnknownVarFromSectionPreset_WiredUIPreset_1 = param5;
         _headerOptionLeft = param6?.headerOptionLeft;
         var _loc7_:TextParam = new TextParam(_headerOptionLeft == null ? 1 : 0,true);
         UnknownVarFromSectionPreset_TextPreset_1 = param2.createText(param4,_loc7_);
         if(param6 != null && param6.titleYOffset > 0)
         {
            UnknownVarFromSectionPreset_TextPreset_1.window.y = param6.titleYOffset;
         }
         _headerLeft.addListItem(UnknownVarFromSectionPreset_TextPreset_1.window);
         if(_headerOptionLeft != null)
         {
            _headerLeft.addListItem(_headerOptionLeft.window);
         }
         _headerContainer.addChild(_headerLeft);
         _headerContainer.addChild(_headerOptionsRightList);
         _container.addListItem(_splitter.window);
         UnknownVarFromSectionPreset_IItemListWindow_1.addListItem(_headerContainer);
         if(param6.expandMode != SectionParam.UnknownVarFromSectionParam_Int_2)
         {
            UnknownVarFromSectionPreset_IItemListWindow_1.addListItem(UnknownVarFromSectionPreset_WiredUIPreset_1.window);
         }
         _container.addListItem(UnknownVarFromSectionPreset_IItemListWindow_1);
         for each(var _loc10_ in param6.miscHeaderOptions)
         {
            addHeaderOption(_loc10_);
         }
         if(param6.sourceTypeSelectorParam != null)
         {
            _loc8_ = param2.createSourceTypeSelector(param6.sourceTypeSelectorParam);
            addHeaderOption(_loc8_);
         }
         if(param6.expandMode != SectionParam.UnknownVarFromSectionParam_Int_1)
         {
            _loc9_ = param2.createCollapseExpandSectionButton(onExpandCollapseClicked,param6.expandMode == SectionParam.UnknownVarFromSectionParam_Int_3);
            addHeaderOption(_loc9_);
         }
      }
      
      public function addHeaderOption(param1:WiredUIPreset) : void
      {
         _headerOptionsRightList.addListItem(param1.window);
         _headerOptionsRight.push(param1);
      }
      
      public function onExpandCollapseClicked(param1:Boolean) : void
      {
         if(param1)
         {
            UnknownVarFromSectionPreset_IItemListWindow_1.addListItem(UnknownVarFromSectionPreset_WiredUIPreset_1.window);
         }
         else
         {
            UnknownVarFromSectionPreset_IItemListWindow_1.removeListItem(UnknownVarFromSectionPreset_WiredUIPreset_1.window);
         }
      }
      
      public function getSourceTypeSelector() : SourceTypeSelectorPreset
      {
         for each(var _loc1_ in _headerOptionsRight)
         {
            if(_loc1_ is SourceTypeSelectorPreset)
            {
               return _loc1_ as SourceTypeSelectorPreset;
            }
         }
         return null;
      }
      
      public function refreshAlignments() : void
      {
         resizeToWidth(_expectedWidth);
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         if(disposed || _container == null)
         {
            return;
         }
         super.resizeToWidth(param1);
         _expectedWidth = param1;
         var _loc4_:int = param1 - 2 * UnknownVarFromWiredUIPreset_WiredStyle_1.sectionLeftRightMargin;
         _splitter.resizeToWidth(param1);
         UnknownVarFromSectionPreset_WiredUIPreset_1.resizeToWidth(_loc4_);
         var _loc3_:int = 0;
         for each(var _loc5_ in _headerOptionsRight)
         {
            _loc5_.resizeToWidth(_loc5_.staticWidth);
            if(_loc5_.window.bottom > _loc3_)
            {
               _loc3_ = _loc5_.window.bottom;
            }
         }
         _headerOptionsRightList.x = _loc4_ - _headerOptionsRightList.width;
         _headerOptionsRightList.height = _loc3_;
         var _loc2_:int = UnknownVarFromSectionPreset_TextPreset_1.window.height;
         if(_headerOptionLeft != null)
         {
            _headerOptionLeft.resizeToWidth(_headerOptionLeft.staticWidth);
            UnknownVarFromSectionPreset_TextPreset_1.resizeToWidth(UnknownVarFromSectionPreset_TextPreset_1.staticWidth);
            if(_headerOptionLeft.window.height > _loc2_)
            {
               _loc2_ = _headerOptionLeft.window.height;
            }
         }
         else
         {
            UnknownVarFromSectionPreset_TextPreset_1.resizeToWidth(_loc4_ - _headerOptionsRightList.width - UnknownVarFromWiredUIPreset_WiredStyle_1.genericHorizontalSpacing);
            _loc2_ = UnknownVarFromSectionPreset_TextPreset_1.window.height;
         }
         _headerLeft.height = _loc2_;
         _headerContainer.width = _loc4_;
         _headerContainer.height = Math.max(_loc3_,_loc2_);
         _container.width = param1;
      }
      
      public function set titleText(param1:String) : void
      {
         UnknownVarFromSectionPreset_TextPreset_1.text = param1;
      }
      
      override public function get window() : IWindowModel
      {
         return _container;
      }
      
      override protected function get childPresets() : Array
      {
         var _loc1_:Array = [_splitter,UnknownVarFromSectionPreset_TextPreset_1,UnknownVarFromSectionPreset_WiredUIPreset_1];
         if(_headerOptionLeft != null)
         {
            _loc1_.push(_headerOptionLeft);
         }
         if(_headerOptionsRight != null)
         {
            return _loc1_.concat(toArray(_headerOptionsRight));
         }
         return _loc1_;
      }
      
      public function set splitterVisible(param1:Boolean) : void
      {
         _splitter.visible = param1;
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
         UnknownVarFromSectionPreset_IItemListWindow_1 = null;
         _headerContainer = null;
         _headerOptionsRightList = null;
         _splitter = null;
         UnknownVarFromSectionPreset_TextPreset_1 = null;
         UnknownVarFromSectionPreset_WiredUIPreset_1 = null;
         _headerLeft = null;
         _headerOptionLeft = null;
      }
   }
}

