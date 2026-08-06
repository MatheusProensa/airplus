package com.sulake.habbo.roomevents.wired_setup.uibuilder.styles
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IDropBaseController_1;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IHTMLTextController;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents2;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.components.UnknownICoreWindowComponents5;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   
   public class WiredStyle
   {
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      public function WiredStyle(param1:HabboUserDefinedRoomEvents)
      {
         super();
         _roomEvents = param1;
      }
      
      protected function get styleTemplate() : IWindowController_1
      {
         return null;
      }
      
      public function get radioButtonSpacing() : int
      {
         return 0;
      }
      
      public function get checkboxSpacing() : int
      {
         return 0;
      }
      
      public function get checkboxYOffset() : int
      {
         return 0;
      }
      
      public function get radioButtonYOffset() : int
      {
         return 0;
      }
      
      public function get namedTextYOffset() : int
      {
         return 0;
      }
      
      public function get namedInputOffset() : int
      {
         return 0;
      }
      
      public function get namedDropdownOffset() : int
      {
         return 0;
      }
      
      public function get genericHorizontalSpacing() : int
      {
         return 0;
      }
      
      public function get genericVerticalSpacing() : int
      {
         return 0;
      }
      
      public function get sectionSpacing() : int
      {
         return 0;
      }
      
      public function get sectionLeftRightMargin() : int
      {
         return 0;
      }
      
      public function get headerMargin() : int
      {
         return 0;
      }
      
      public function get headerBottomMarginWithLink() : int
      {
         return 0;
      }
      
      public function get headerNameFontSize() : int
      {
         return 0;
      }
      
      public function get frameColor() : uint
      {
         return 0;
      }
      
      public function get backgroundColor() : uint
      {
         return 0;
      }
      
      public function get advancedBackgroundColor() : uint
      {
         return 0;
      }
      
      public function get yellowTextColor() : uint
      {
         return 0;
      }
      
      public function get softTextColor() : uint
      {
         return 0;
      }
      
      public function get redTextColor() : uint
      {
         return 0;
      }
      
      public function get minimumOptionHeight() : int
      {
         return 0;
      }
      
      public function get minimumOptionSpacing() : int
      {
         return 0;
      }
      
      public function get optionExtraUnderSpacing() : int
      {
         return 0;
      }
      
      public function get optionExtraUnderLeftMargin() : int
      {
         return 0;
      }
      
      public function get LRContainerMargin() : int
      {
         return 0;
      }
      
      public function get LRContainerSpacing() : int
      {
         return 0;
      }
      
      public function get LRContainerTopBottomPadding() : int
      {
         return 0;
      }
      
      public function get inputSourceListMinHeight() : int
      {
         return 0;
      }
      
      public function get buttonRowSpacing() : int
      {
         return 0;
      }
      
      public function get menuRightOffset() : int
      {
         return 0;
      }
      
      public function get verticalSplitterColor() : uint
      {
         return 0;
      }
      
      public function get name() : String
      {
         return "";
      }
      
      public function get isVolter() : Boolean
      {
         return false;
      }
      
      public function get useInnerBorder() : Boolean
      {
         return false;
      }
      
      public function get containerButtonPaddingTop() : int
      {
         return 0;
      }
      
      public function get containerButtonPaddingLeft() : int
      {
         return 0;
      }
      
      public function get paddedSectionTop() : int
      {
         return 0;
      }
      
      public function get paddedSectionLeft() : int
      {
         return 0;
      }
      
      public function createSplitterView() : IWindowController_1
      {
         return recreateElement("ruler_view") as IWindowController_1;
      }
      
      public function createSplitterVerticalView() : IWindowController_1
      {
         return recreateElement("ruler_view_vertical") as IWindowController_1;
      }
      
      public function createTextView(param1:Boolean = true) : ITextWindow
      {
         return recreateElement(param1 ? "text_bold_view" : "text_view") as ITextWindow;
      }
      
      public function createHtmlView() : IHTMLTextController
      {
         return recreateElement("text_html") as IHTMLTextController;
      }
      
      public function createTextInputView() : IWindowModel
      {
         return recreateElement("input_template") as IWindowModel;
      }
      
      public function createCheckboxView() : UnknownICoreWindowComponents2
      {
         return recreateElement("checkbox_view") as UnknownICoreWindowComponents2;
      }
      
      public function createRadioButtonView() : IRadioButtonWindow
      {
         return recreateElement("radiobutton_view") as IRadioButtonWindow;
      }
      
      public function createExpandCollapseSectionRegion() : IRegionWindow
      {
         return recreateElement("expand_collapse_region") as IRegionWindow;
      }
      
      public function createSourceTypeSelector() : IItemListWindow
      {
         return recreateElement("sourcetype_selector_view") as IItemListWindow;
      }
      
      public function createDropdown() : IDropBaseController_1
      {
         return recreateElement("dropdown_view") as IDropBaseController_1;
      }
      
      public function createSlider() : IWindowController_1
      {
         return recreateElement("slider") as IWindowController_1;
      }
      
      public function createButton() : UnknownICoreWindowComponents4
      {
         return recreateElement("button") as UnknownICoreWindowComponents4;
      }
      
      public function createAssetButton() : UnknownICoreWindowComponents5
      {
         return recreateElement("asset_button") as UnknownICoreWindowComponents5;
      }
      
      public function createIconButton(param1:String) : IWindowModel
      {
         return recreateElement("iconbutton_" + param1);
      }
      
      public function createMiniButton() : IWindowModel
      {
         return recreateElement("mini_button_view");
      }
      
      public function createFrame() : IFrameController
      {
         return recreateElement("frame") as IFrameController;
      }
      
      public function createQuickMenu() : IWindowController_1
      {
         return recreateElement("quick_menu") as IWindowController_1;
      }
      
      public function createInnerBorder() : UnknownICoreWindowComponents6
      {
         return recreateElement("inner_border") as UnknownICoreWindowComponents6;
      }
      
      public function createBorder() : UnknownICoreWindowComponents6
      {
         return recreateElement("border") as UnknownICoreWindowComponents6;
      }
      
      public function createContainerButton() : UnknownICoreWindowComponents5
      {
         return recreateElement("container_button") as UnknownICoreWindowComponents5;
      }
      
      private function recreateElement(param1:String) : IWindowModel
      {
         var _loc2_:IWindowModel = styleTemplate.findChildByName(param1);
         _loc2_ = _loc2_.clone();
         _loc2_.visible = true;
         return _loc2_;
      }
      
      public function createTradeRequirementRule() : UnknownICoreWindowComponents6
      {
         return recreateElement("requirement_rule") as UnknownICoreWindowComponents6;
      }
      
      public function createProductIconPreviewer() : UnknownICoreWindowComponents6
      {
         return recreateElement("product_icon_previewer") as UnknownICoreWindowComponents6;
      }
   }
}

