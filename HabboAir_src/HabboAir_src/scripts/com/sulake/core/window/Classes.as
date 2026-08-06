package com.sulake.core.window
{
   import com.sulake.core.window.components.*;
   import flash.utils.Dictionary;
   
   public class Classes
   {
      protected static var UnknownVarFromClasses_Dictionary_1:Dictionary;
      
      public function Classes()
      {
         super();
      }
      
      public static function init() : void
      {
         if(!UnknownVarFromClasses_Dictionary_1)
         {
            UnknownVarFromClasses_Dictionary_1 = new Dictionary();
            UnknownVarFromClasses_Dictionary_1[0] = WindowController;
            UnknownVarFromClasses_Dictionary_1[40] = ActivatorController;
            UnknownVarFromClasses_Dictionary_1[2] = BackgroundController;
            UnknownVarFromClasses_Dictionary_1[30] = BorderController;
            UnknownVarFromClasses_Dictionary_1[17] = BoxSizerController;
            UnknownVarFromClasses_Dictionary_1[45] = BubbleController;
            UnknownVarFromClasses_Dictionary_1[46] = WindowController;
            UnknownVarFromClasses_Dictionary_1[47] = WindowController;
            UnknownVarFromClasses_Dictionary_1[48] = WindowController;
            UnknownVarFromClasses_Dictionary_1[49] = WindowController;
            UnknownVarFromClasses_Dictionary_1[60] = ButtonController;
            UnknownVarFromClasses_Dictionary_1[61] = ButtonController;
            UnknownVarFromClasses_Dictionary_1[67] = SelectableButtonController;
            UnknownVarFromClasses_Dictionary_1[68] = SelectableButtonController;
            UnknownVarFromClasses_Dictionary_1[69] = SelectableButtonController;
            UnknownVarFromClasses_Dictionary_1[26] = BitmapFillController;
            UnknownVarFromClasses_Dictionary_1[21] = BitmapWrapperController;
            UnknownVarFromClasses_Dictionary_1[70] = CheckBoxController;
            UnknownVarFromClasses_Dictionary_1[4] = ContainerController;
            UnknownVarFromClasses_Dictionary_1[41] = ContainerButtonController;
            UnknownVarFromClasses_Dictionary_1[72] = CloseButtonController;
            UnknownVarFromClasses_Dictionary_1[20] = DisplayObjectWrapperController;
            UnknownVarFromClasses_Dictionary_1[76] = ScrollBarLiftController;
            UnknownVarFromClasses_Dictionary_1[102] = DropMenuController;
            UnknownVarFromClasses_Dictionary_1[103] = DropMenuItemController;
            UnknownVarFromClasses_Dictionary_1[105] = DropListController;
            UnknownVarFromClasses_Dictionary_1[106] = DropListItemController;
            UnknownVarFromClasses_Dictionary_1[15] = FormattedTextController;
            UnknownVarFromClasses_Dictionary_1[35] = FrameController;
            UnknownVarFromClasses_Dictionary_1[24] = GradientController;
            UnknownVarFromClasses_Dictionary_1[6] = HeaderController;
            UnknownVarFromClasses_Dictionary_1[11] = HTMLTextController;
            UnknownVarFromClasses_Dictionary_1[1] = IconController;
            UnknownVarFromClasses_Dictionary_1[79] = IconButtonController;
            UnknownVarFromClasses_Dictionary_1[50] = ItemListController;
            UnknownVarFromClasses_Dictionary_1[51] = ItemListController;
            UnknownVarFromClasses_Dictionary_1[50] = ItemListController;
            UnknownVarFromClasses_Dictionary_1[52] = ItemGridController;
            UnknownVarFromClasses_Dictionary_1[54] = ItemGridController;
            UnknownVarFromClasses_Dictionary_1[53] = ItemGridController;
            UnknownVarFromClasses_Dictionary_1[12] = TextLabelController;
            UnknownVarFromClasses_Dictionary_1[14] = TextLinkController;
            UnknownVarFromClasses_Dictionary_1[78] = PasswordFieldController;
            UnknownVarFromClasses_Dictionary_1[71] = RadioButtonController;
            UnknownVarFromClasses_Dictionary_1[5] = RegionController;
            UnknownVarFromClasses_Dictionary_1[120] = ScalerController;
            UnknownVarFromClasses_Dictionary_1[130] = ScrollBarController;
            UnknownVarFromClasses_Dictionary_1[131] = ScrollBarController;
            UnknownVarFromClasses_Dictionary_1[139] = ButtonController;
            UnknownVarFromClasses_Dictionary_1[137] = ButtonController;
            UnknownVarFromClasses_Dictionary_1[138] = ButtonController;
            UnknownVarFromClasses_Dictionary_1[136] = ButtonController;
            UnknownVarFromClasses_Dictionary_1[132] = ScrollBarLiftController;
            UnknownVarFromClasses_Dictionary_1[133] = ScrollBarLiftController;
            UnknownVarFromClasses_Dictionary_1[134] = WindowController;
            UnknownVarFromClasses_Dictionary_1[135] = WindowController;
            UnknownVarFromClasses_Dictionary_1[56] = ScrollableItemListWindow;
            UnknownVarFromClasses_Dictionary_1[140] = ScrollableItemGridWindow;
            UnknownVarFromClasses_Dictionary_1[42] = SelectorController;
            UnknownVarFromClasses_Dictionary_1[43] = SelectorListController;
            UnknownVarFromClasses_Dictionary_1[22] = ShapeController;
            UnknownVarFromClasses_Dictionary_1[25] = StrokeController;
            UnknownVarFromClasses_Dictionary_1[23] = StaticBitmapWrapperController;
            UnknownVarFromClasses_Dictionary_1[93] = TabButtonController;
            UnknownVarFromClasses_Dictionary_1[94] = TabContainerButtonController;
            UnknownVarFromClasses_Dictionary_1[90] = ContainerController;
            UnknownVarFromClasses_Dictionary_1[91] = TabContextController;
            UnknownVarFromClasses_Dictionary_1[92] = SelectorListController;
            UnknownVarFromClasses_Dictionary_1[10] = TextController;
            UnknownVarFromClasses_Dictionary_1[77] = TextFieldController;
            UnknownVarFromClasses_Dictionary_1[8] = ToolTipController;
            UnknownVarFromClasses_Dictionary_1[16] = WidgetWindowController;
         }
      }
      
      public static function getWindowClassByType(param1:uint) : Class
      {
         return UnknownVarFromClasses_Dictionary_1[param1];
      }
   }
}

