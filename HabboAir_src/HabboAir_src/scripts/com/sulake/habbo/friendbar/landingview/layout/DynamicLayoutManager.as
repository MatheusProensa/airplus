package com.sulake.habbo.friendbar.landingview.layout
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import flash.geom.Rectangle;
   
   public class DynamicLayoutManager implements IComponentInterfaceQueue
   {
      public static const PLACEHOLDER_NAME:String = "placeholder_dynamic_widget_slots";
      
      public static const CONTENT_AREA_START_X:int = 230;
      
      private static const NUMBER_OF_SLOTS:int = 5;
      
      private static const RESIZE_TOLERANCE_SCROLLBAR_VISIBILITY:int = 6;
      
      private static const ABSOLUTE_MINIMUM_HEIGHT:int = 360;
      
      private var _layout:WidgetContainerLayout;
      
      private var UnknownVarFromDynamicLayoutManager_IItemListWindow_1:IItemListWindow;
      
      private var UnknownVarFromDynamicLayoutManager_IItemListWindow_2:IItemListWindow;
      
      private var UnknownVarFromDynamicLayoutManager_IItemListWindow_3:IItemListWindow;
      
      private var UnknownVarFromDynamicLayoutManager_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromDynamicLayoutManager_IItemListWindow_4:IItemListWindow;
      
      private var UnknownVarFromDynamicLayoutManager_IWindowController_1_2:IWindowController_1;
      
      private var UnknownVarFromDynamicLayoutManager_Vector_1:Vector.<IWindowController_1>;
      
      private var UnknownVarFromDynamicLayoutManager_IItemListWindow_5:IItemListWindow;
      
      private var UnknownVarFromDynamicLayoutManager_IItemListWindow_6:IItemListWindow;
      
      private var UnknownVarFromDynamicLayoutManager_IWindowModel_1:IWindowModel;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromDynamicLayoutManager_Boolean_1:Boolean = false;
      
      private var UnknownVarFromDynamicLayoutManager_CommonWidgetSettings_1:CommonWidgetSettings;
      
      private var UnknownVarFromDynamicLayoutManager_Int_1:int = 10;
      
      private var UnknownVarFromDynamicLayoutManager_Int_2:int = 50;
      
      private var UnknownVarFromDynamicLayoutManager_Int_3:int = 10;
      
      private var UnknownVarFromDynamicLayoutManager_Int_4:int = 80;
      
      private var UnknownVarFromDynamicLayoutManager_Int_5:int = 10;
      
      private var UnknownVarFromDynamicLayoutManager_Int_6:int = 60;
      
      private var UnknownVarFromDynamicLayoutManager_Int_7:int = -1;
      
      private var _topItemListInitialWidth:int = -1;
      
      private var UnknownVarFromDynamicLayoutManager_Boolean_2:Boolean = false;
      
      private var UnknownVarFromDynamicLayoutManager_IWindowModel_2:IWindowModel = null;
      
      public function DynamicLayoutManager(param1:WidgetContainerLayout, param2:CommonWidgetSettings)
      {
         var _loc5_:int = 0;
         UnknownVarFromDynamicLayoutManager_Vector_1 = new Vector.<IWindowController_1>(5);
         super();
         _layout = param1;
         UnknownVarFromDynamicLayoutManager_CommonWidgetSettings_1 = param2;
         _window = IWindowController_1(_layout.landingView.getXmlWindow("dynamic_widget_grid"));
         var _loc6_:IWindowModel = _layout.window.findChildByName("placeholder_dynamic_widget_slots");
         var _loc3_:IWindowController_1 = IWindowController_1(_loc6_.parent);
         _loc3_.addChildAt(_window,_loc3_.getChildIndex(_loc6_));
         _loc3_.removeChild(_loc6_);
         UnknownVarFromDynamicLayoutManager_IItemListWindow_1 = IItemListWindow(_window.findChildByName("widgetlist_fromtop"));
         UnknownVarFromDynamicLayoutManager_IWindowController_1_1 = IWindowController_1(_window.findChildByName("center_slots_container"));
         UnknownVarFromDynamicLayoutManager_IItemListWindow_2 = IItemListWindow(_window.findChildByName("widget_slots_center_scrollable"));
         UnknownVarFromDynamicLayoutManager_IItemListWindow_3 = IItemListWindow(_window.findChildByName("widget_slots_center_left"));
         UnknownVarFromDynamicLayoutManager_IItemListWindow_4 = IItemListWindow(_window.findChildByName("widget_slots_center_right"));
         UnknownVarFromDynamicLayoutManager_IWindowController_1_2 = IWindowController_1(_window.findChildByName("widget_slots_right"));
         UnknownVarFromDynamicLayoutManager_IItemListWindow_5 = IItemListWindow(_window.findChildByName("widget_slot_4_root"));
         UnknownVarFromDynamicLayoutManager_IItemListWindow_6 = IItemListWindow(_window.findChildByName("widget_slot_5_root"));
         UnknownVarFromDynamicLayoutManager_IWindowModel_1 = _layout.landingView.getXmlWindow("dynamic_widget_grid_separator");
         _loc5_ = 0;
         while(_loc5_ < 6)
         {
            UnknownVarFromDynamicLayoutManager_Vector_1[_loc5_] = IWindowController_1(_window.findChildByName("widget_slot_" + (_loc5_ + 1)));
            if(UnknownVarFromDynamicLayoutManager_Vector_1[_loc5_] != null)
            {
               UnknownVarFromDynamicLayoutManager_Vector_1[_loc5_].addEventListener("WE_RESIZED",contractCenterContainer);
            }
            _loc5_++;
         }
         var _loc7_:int = _layout.landingView.dynamicLayoutLeftPaneWidth;
         var _loc4_:int = _layout.landingView.dynamicLayoutRightPaneWidth;
         UnknownVarFromDynamicLayoutManager_IItemListWindow_3.width = _loc7_;
         UnknownVarFromDynamicLayoutManager_IItemListWindow_3.limits.maxWidth = _loc7_;
         UnknownVarFromDynamicLayoutManager_IItemListWindow_5.width = _loc7_;
         UnknownVarFromDynamicLayoutManager_IItemListWindow_4.width = _loc4_;
         UnknownVarFromDynamicLayoutManager_IWindowController_1_2.width = _loc4_;
         UnknownVarFromDynamicLayoutManager_IWindowController_1_2.limits.maxWidth = _loc4_;
         UnknownVarFromDynamicLayoutManager_IItemListWindow_6.width = _loc4_;
         UnknownVarFromDynamicLayoutManager_IItemListWindow_2.arrangeListItems();
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         if(!disposed)
         {
            _loc1_ = 0;
            while(_loc1_ < 6)
            {
               if(UnknownVarFromDynamicLayoutManager_Vector_1[_loc1_])
               {
                  UnknownVarFromDynamicLayoutManager_Vector_1[_loc1_].dispose();
               }
               UnknownVarFromDynamicLayoutManager_Vector_1[_loc1_] = null;
               _loc1_++;
            }
            if(_window)
            {
               _window.dispose();
               _window = null;
            }
            _layout = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _layout == null;
      }
      
      public function getDynamicSlotContainer(param1:int) : IWindowController_1
      {
         return UnknownVarFromDynamicLayoutManager_Vector_1[param1];
      }
      
      public function enableSeparator(param1:int, param2:String) : void
      {
         var _loc3_:IItemListWindow = null;
         var _loc4_:ITextWindow = null;
         switch(param1 - 4)
         {
            case 0:
               _loc3_ = UnknownVarFromDynamicLayoutManager_IItemListWindow_5;
               break;
            case 1:
               _loc3_ = UnknownVarFromDynamicLayoutManager_IItemListWindow_6;
               break;
            default:
               _loc3_ = null;
         }
         if(_loc3_)
         {
            if(_loc3_.numListItems < 2)
            {
               _loc3_.addListItemAt(UnknownVarFromDynamicLayoutManager_IWindowModel_1.clone(),0);
            }
            _loc4_ = ITextWindow(IItemListWindow(_loc3_.getListItemAt(0)).getListItemByName("separator_title"));
            _loc4_.caption = "${" + param2 + "}";
            if(UnknownVarFromDynamicLayoutManager_CommonWidgetSettings_1 != null)
            {
               if(UnknownVarFromDynamicLayoutManager_CommonWidgetSettings_1.isTextColorSet)
               {
                  _loc4_.textColor = UnknownVarFromDynamicLayoutManager_CommonWidgetSettings_1.textColor;
               }
               if(UnknownVarFromDynamicLayoutManager_CommonWidgetSettings_1.isEtchingColorSet)
               {
                  _loc4_.etchingColor = UnknownVarFromDynamicLayoutManager_CommonWidgetSettings_1.etchingColor;
               }
               if(UnknownVarFromDynamicLayoutManager_CommonWidgetSettings_1.isEtchingPositionSet)
               {
                  _loc4_.etchingPosition = UnknownVarFromDynamicLayoutManager_CommonWidgetSettings_1.etchingPosition;
               }
            }
         }
      }
      
      private function isSlotOccupied(param1:int) : Boolean
      {
         return UnknownVarFromDynamicLayoutManager_Vector_1[param1].numChildren > 0;
      }
      
      public function resizeTo(param1:int, param2:int) : void
      {
         UnknownVarFromDynamicLayoutManager_IItemListWindow_1.height = Math.min(param2,topItemListInitialHeight);
         UnknownVarFromDynamicLayoutManager_IItemListWindow_1.height = Math.max(360,UnknownVarFromDynamicLayoutManager_IItemListWindow_1.height);
         UnknownVarFromDynamicLayoutManager_IItemListWindow_1.width = Math.min(param1,topItemListInitialWidth);
         applyVerticalSize();
      }
      
      public function get topItemListInitialHeight() : int
      {
         if(UnknownVarFromDynamicLayoutManager_Int_7 == -1)
         {
            UnknownVarFromDynamicLayoutManager_Int_7 = UnknownVarFromDynamicLayoutManager_IItemListWindow_1.height;
         }
         return UnknownVarFromDynamicLayoutManager_Int_7;
      }
      
      public function get topItemListInitialWidth() : int
      {
         if(_topItemListInitialWidth == -1)
         {
            _topItemListInitialWidth = UnknownVarFromDynamicLayoutManager_IItemListWindow_1.width;
         }
         return _topItemListInitialWidth;
      }
      
      private function applyVerticalSize() : void
      {
         var _loc1_:int = 0;
         clearEmptySlotsForSpace();
         alignTopWidgetRow();
         alignBottomWidgetRow();
         resetToMaximumSpacing();
         setVerticalSpacing(topItemListContentHeight - UnknownVarFromDynamicLayoutManager_IItemListWindow_1.height);
         contractCenterContainer();
         setHorizontalSpacing();
         if(!UnknownVarFromDynamicLayoutManager_Boolean_2)
         {
            _loc1_ = 0;
            while(_loc1_ < 6)
            {
               if(UnknownVarFromDynamicLayoutManager_Vector_1[_loc1_] != null)
               {
                  UnknownVarFromDynamicLayoutManager_Vector_1[_loc1_].addEventListener("WE_RESIZED",updateLayout);
               }
               _loc1_++;
            }
         }
         UnknownVarFromDynamicLayoutManager_Boolean_2 = true;
         UnknownVarFromDynamicLayoutManager_IWindowModel_2 = null;
      }
      
      private function updateLayout(param1:WindowEvent = null) : void
      {
         if(UnknownVarFromDynamicLayoutManager_IWindowModel_2 == null)
         {
            UnknownVarFromDynamicLayoutManager_IWindowModel_2 = param1.window;
            applyVerticalSize();
         }
      }
      
      private function clearEmptySlotsForSpace() : void
      {
         var _loc1_:int = 0;
         if(!isSlotOccupied(0))
         {
            UnknownVarFromDynamicLayoutManager_Vector_1[0].height = 0;
         }
         _loc1_ = 1;
         while(_loc1_ <= 4)
         {
            if(!isSlotOccupied(_loc1_))
            {
               UnknownVarFromDynamicLayoutManager_Vector_1[_loc1_].height = 1;
            }
            _loc1_++;
         }
      }
      
      private function alignBottomWidgetRow() : void
      {
         var _loc1_:int = 0;
         if(isSlotOccupied(3) || isSlotOccupied(4))
         {
            _loc1_ = Math.max(UnknownVarFromDynamicLayoutManager_Vector_1[3].height,UnknownVarFromDynamicLayoutManager_Vector_1[4].height);
            UnknownVarFromDynamicLayoutManager_Vector_1[3].height = _loc1_;
            UnknownVarFromDynamicLayoutManager_Vector_1[4].height = _loc1_;
            if(isSlotOccupied(3))
            {
               UnknownVarFromDynamicLayoutManager_Vector_1[3].getChildAt(0).y = 0;
               UnknownVarFromDynamicLayoutManager_Vector_1[3].width = _layout.landingView.dynamicLayoutLeftPaneWidth;
            }
            if(isSlotOccupied(4))
            {
               UnknownVarFromDynamicLayoutManager_Vector_1[4].getChildAt(0).y = 0;
               UnknownVarFromDynamicLayoutManager_Vector_1[4].width = _layout.landingView.dynamicLayoutRightPaneWidth;
            }
         }
      }
      
      private function alignTopWidgetRow() : int
      {
         var _loc1_:int = 0;
         if(isSlotOccupied(1) || isSlotOccupied(2))
         {
            if(!UnknownVarFromDynamicLayoutManager_Boolean_1)
            {
               _loc1_ = Math.max(UnknownVarFromDynamicLayoutManager_Vector_1[1].height,UnknownVarFromDynamicLayoutManager_Vector_1[2].height);
               UnknownVarFromDynamicLayoutManager_Vector_1[1].height = _loc1_;
               UnknownVarFromDynamicLayoutManager_Vector_1[2].height = _loc1_;
            }
            if(isSlotOccupied(1))
            {
               UnknownVarFromDynamicLayoutManager_Vector_1[1].getChildAt(0).y = 0;
               UnknownVarFromDynamicLayoutManager_Vector_1[1].width = _layout.landingView.dynamicLayoutLeftPaneWidth;
            }
            if(isSlotOccupied(2))
            {
               UnknownVarFromDynamicLayoutManager_Vector_1[2].getChildAt(0).y = 0;
               UnknownVarFromDynamicLayoutManager_Vector_1[2].width = _layout.landingView.dynamicLayoutRightPaneWidth;
            }
         }
         return _loc1_;
      }
      
      private function setHorizontalSpacing() : void
      {
         var _loc1_:int = _topItemListInitialWidth - UnknownVarFromDynamicLayoutManager_IItemListWindow_1.width;
         if(_loc1_ > UnknownVarFromDynamicLayoutManager_Int_6 - UnknownVarFromDynamicLayoutManager_Int_5)
         {
            UnknownVarFromDynamicLayoutManager_IItemListWindow_2.spacing = UnknownVarFromDynamicLayoutManager_Int_5;
         }
         else
         {
            UnknownVarFromDynamicLayoutManager_IItemListWindow_2.spacing = Math.min(UnknownVarFromDynamicLayoutManager_Int_6,UnknownVarFromDynamicLayoutManager_Int_6 - _loc1_);
         }
      }
      
      private function setVerticalSpacing(param1:int) : void
      {
         var _loc2_:int = UnknownVarFromDynamicLayoutManager_Int_2 - UnknownVarFromDynamicLayoutManager_Int_1;
         var _loc3_:int = UnknownVarFromDynamicLayoutManager_Int_4 - UnknownVarFromDynamicLayoutManager_Int_3;
         param1 += UnknownVarFromDynamicLayoutManager_Int_1 + UnknownVarFromDynamicLayoutManager_Int_3;
         if(param1 <= 0)
         {
            UnknownVarFromDynamicLayoutManager_IItemListWindow_1.spacing = UnknownVarFromDynamicLayoutManager_Int_3;
            UnknownVarFromDynamicLayoutManager_IItemListWindow_3.spacing = UnknownVarFromDynamicLayoutManager_Int_2;
            UnknownVarFromDynamicLayoutManager_IItemListWindow_4.spacing = UnknownVarFromDynamicLayoutManager_Int_2;
         }
         else if(param1 < _loc2_)
         {
            UnknownVarFromDynamicLayoutManager_IItemListWindow_1.spacing = UnknownVarFromDynamicLayoutManager_Int_3;
            UnknownVarFromDynamicLayoutManager_IItemListWindow_3.spacing = UnknownVarFromDynamicLayoutManager_Int_2 - param1;
            UnknownVarFromDynamicLayoutManager_IItemListWindow_4.spacing = UnknownVarFromDynamicLayoutManager_Int_2 - param1;
         }
         else if(param1 < _loc2_ + _loc3_)
         {
            UnknownVarFromDynamicLayoutManager_IItemListWindow_1.spacing = UnknownVarFromDynamicLayoutManager_Int_3;
            UnknownVarFromDynamicLayoutManager_IItemListWindow_3.spacing = UnknownVarFromDynamicLayoutManager_Int_1;
            UnknownVarFromDynamicLayoutManager_IItemListWindow_4.spacing = UnknownVarFromDynamicLayoutManager_Int_1;
         }
         else
         {
            UnknownVarFromDynamicLayoutManager_IItemListWindow_1.spacing = UnknownVarFromDynamicLayoutManager_Int_3;
            UnknownVarFromDynamicLayoutManager_IItemListWindow_3.spacing = UnknownVarFromDynamicLayoutManager_Int_1;
            UnknownVarFromDynamicLayoutManager_IItemListWindow_4.spacing = UnknownVarFromDynamicLayoutManager_Int_1;
         }
      }
      
      private function resetToMaximumSpacing() : void
      {
         UnknownVarFromDynamicLayoutManager_IItemListWindow_2.spacing = UnknownVarFromDynamicLayoutManager_Int_6;
         UnknownVarFromDynamicLayoutManager_IItemListWindow_3.spacing = UnknownVarFromDynamicLayoutManager_Int_2;
         UnknownVarFromDynamicLayoutManager_IItemListWindow_4.spacing = UnknownVarFromDynamicLayoutManager_Int_2;
         UnknownVarFromDynamicLayoutManager_IItemListWindow_1.spacing = UnknownVarFromDynamicLayoutManager_Int_4;
         UnknownVarFromDynamicLayoutManager_IItemListWindow_3.invalidate();
         UnknownVarFromDynamicLayoutManager_IItemListWindow_4.invalidate();
         UnknownVarFromDynamicLayoutManager_IItemListWindow_2.invalidate();
         UnknownVarFromDynamicLayoutManager_IItemListWindow_1.invalidate();
         UnknownVarFromDynamicLayoutManager_IWindowController_1_1.invalidate();
      }
      
      private function get topItemListContentHeight() : int
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < UnknownVarFromDynamicLayoutManager_IItemListWindow_1.numListItems)
         {
            _loc2_ = UnknownVarFromDynamicLayoutManager_IItemListWindow_1.getListItemAt(_loc3_).height;
            _loc1_ += _loc2_;
            if(_loc3_ > 0)
            {
               _loc1_ += UnknownVarFromDynamicLayoutManager_IItemListWindow_1.spacing;
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      private function contractCenterContainer(param1:WindowEvent = null) : void
      {
         if(param1 != null && !UnknownVarFromDynamicLayoutManager_Boolean_2)
         {
            return;
         }
         UnknownVarFromDynamicLayoutManager_IItemListWindow_3.invalidate();
         UnknownVarFromDynamicLayoutManager_IItemListWindow_4.invalidate();
         UnknownVarFromDynamicLayoutManager_IItemListWindow_2.height = Math.max(UnknownVarFromDynamicLayoutManager_IItemListWindow_3.height,UnknownVarFromDynamicLayoutManager_IItemListWindow_4.height);
         UnknownVarFromDynamicLayoutManager_IWindowController_1_1.height = Math.max(UnknownVarFromDynamicLayoutManager_IItemListWindow_3.height,UnknownVarFromDynamicLayoutManager_IItemListWindow_4.height);
      }
      
      public function set ignoreBottomRightSlot(param1:Boolean) : void
      {
         UnknownVarFromDynamicLayoutManager_Boolean_1 = param1;
      }
      
      private function logFinalPositions() : void
      {
         var _loc2_:int = 0;
         Logger.log("***** Final positions *****");
         var _loc1_:Rectangle = new Rectangle();
         _window.getGlobalRectangle(_loc1_);
         Logger.log("Window rect\t\t\t\t\t\t: " + _loc1_);
         UnknownVarFromDynamicLayoutManager_IItemListWindow_1.getGlobalRectangle(_loc1_);
         Logger.log("All items list rect\t\t\t\t: " + _loc1_);
         UnknownVarFromDynamicLayoutManager_IWindowController_1_1.getGlobalRectangle(_loc1_);
         Logger.log("Center container itemlist rect\t: " + _loc1_);
         UnknownVarFromDynamicLayoutManager_IItemListWindow_2.getGlobalRectangle(_loc1_);
         Logger.log("Center itemlist rect\t\t\t: " + _loc1_);
         UnknownVarFromDynamicLayoutManager_IItemListWindow_3.getGlobalRectangle(_loc1_);
         Logger.log("Left pane itemlist rect\t\t\t: " + _loc1_);
         UnknownVarFromDynamicLayoutManager_IItemListWindow_4.getGlobalRectangle(_loc1_);
         Logger.log("Right pane itemlist rect\t\t: " + _loc1_);
         UnknownVarFromDynamicLayoutManager_IWindowController_1_2.getGlobalRectangle(_loc1_);
         Logger.log("Right pane container rect\t\t: " + _loc1_);
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            UnknownVarFromDynamicLayoutManager_Vector_1[_loc2_].getGlobalRectangle(_loc1_);
            Logger.log("Slot " + _loc2_ + " rect\t\t\t    : " + _loc1_);
            _loc2_++;
         }
      }
   }
}

