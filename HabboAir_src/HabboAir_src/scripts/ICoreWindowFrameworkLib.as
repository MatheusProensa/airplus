package
{
   import com.sulake.core.window.IWindowContext_2;
   import com.sulake.core.window.IWindowContext_3;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IDesktopController;
   import com.sulake.core.window.components.IDisplayObjectWrapperController;
   import com.sulake.core.window.components.IDropBaseController_1;
   import com.sulake.core.window.components.IDropListItemController;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IHeaderController;
   import com.sulake.core.window.components.IIconWindow;
   import com.sulake.core.window.components.IInteractiveWindow;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.INotifyWindow;
   import com.sulake.core.window.components.IRadioButtonSelectionWindow;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IScalerWindow;
   import com.sulake.core.window.components.IScrollBarLiftController;
   import com.sulake.core.window.components.IScrollableWindow;
   import com.sulake.core.window.components.IScrollbarWindow;
   import com.sulake.core.window.components.ISelectableWindow;
   import com.sulake.core.window.components.ISelectorListWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.ITabButtonWindow;
   import com.sulake.core.window.components.ITabContentWindow;
   import com.sulake.core.window.components.ITabContextWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IToolBarWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents1;
   import com.sulake.core.window.components.UnknownICoreWindowComponents2;
   import com.sulake.core.window.components.UnknownICoreWindowComponents3;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.components.UnknownICoreWindowComponents5;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.components.UnknownICoreWindowComponents7;
   import com.sulake.core.window.enum.UnknownCoreWindowEnum1;
   import com.sulake.core.window.enum.UnknownCoreWindowEnum2;
   import com.sulake.core.window.enum.UnknownCoreWindowEnum3;
   import com.sulake.core.window.enum.UnknownCoreWindowEnum4;
   import com.sulake.core.window.enum.UnknownCoreWindowEnum5;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMessage;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.utils.IMargins;
   import com.sulake.iid.IIDCoreWindowManager;
   
   [SecureSWF(rename="false")]
   public class ICoreWindowFrameworkLib
   {
      public static var IIDCoreWindowManager:Class = com.sulake.iid.IIDCoreWindowManager;
      
      public static var UnknownVarFromICoreWindowFrameworkLib_Class_1:Class = IWindowContext_2;
      
      public static var UnknownVarFromICoreWindowFrameworkLib_Class_2:Class = IWindowModel;
      
      public static var UnknownVarFromICoreWindowFrameworkLib_Class_3:Class = IWindowController_1;
      
      public static var UnknownVarFromICoreWindowFrameworkLib_Class_4:Class = IWindowContext_3;
      
      public static var UnknownVarFromICoreWindowFrameworkLib_Class_5:Class = UnknownICoreWindowComponents7;
      
      public static var UnknownVarFromICoreWindowFrameworkLib_Class_6:Class = IBitmapWrapperController;
      
      public static var UnknownVarFromICoreWindowFrameworkLib_Class_7:Class = UnknownICoreWindowComponents6;
      
      public static var UnknownVarFromICoreWindowFrameworkLib_Class_8:Class = UnknownICoreWindowComponents4;
      
      public static var UnknownVarFromICoreWindowFrameworkLib_Class_9:Class = UnknownICoreWindowComponents3;
      
      public static var UnknownVarFromICoreWindowFrameworkLib_Class_10:Class = UnknownICoreWindowComponents2;
      
      public static var UnknownVarFromICoreWindowFrameworkLib_Class_11:Class = UnknownICoreWindowComponents5;
      
      public static var UnknownVarFromICoreWindowFrameworkLib_Class_12:Class = IDesktopController;
      
      public static var UnknownVarFromICoreWindowFrameworkLib_Class_13:Class = IDisplayObjectWrapperController;
      
      public static var UnknownVarFromICoreWindowFrameworkLib_Class_14:Class = IScrollBarLiftController;
      
      public static var UnknownVarFromICoreWindowFrameworkLib_Class_15:Class = IDropListItemController;
      
      public static var UnknownVarFromICoreWindowFrameworkLib_Class_16:Class = IDropBaseController_1;
      
      public static var UnknownVarFromICoreWindowFrameworkLib_Class_17:Class = IFrameController;
      
      public static var UnknownVarFromICoreWindowFrameworkLib_Class_18:Class = IHeaderController;
      
      public static var IIconWindow:Class = com.sulake.core.window.components.IIconWindow;
      
      public static var IInteractiveWindow:Class = com.sulake.core.window.components.IInteractiveWindow;
      
      public static var IItemGridWindow:Class = com.sulake.core.window.components.IItemGridWindow;
      
      public static var IItemListWindow:Class = com.sulake.core.window.components.IItemListWindow;
      
      public static var INotifyWindow:Class = com.sulake.core.window.components.INotifyWindow;
      
      public static var UnknownVarFromICoreWindowFrameworkLib_Class_19:Class = UnknownICoreWindowComponents1;
      
      public static var IRadioButtonSelectionWindow:Class = com.sulake.core.window.components.IRadioButtonSelectionWindow;
      
      public static var IRadioButtonWindow:Class = com.sulake.core.window.components.IRadioButtonWindow;
      
      public static var IRegionWindow:Class = com.sulake.core.window.components.IRegionWindow;
      
      public static var IScalerWindow:Class = com.sulake.core.window.components.IScalerWindow;
      
      public static var IScrollableWindow:Class = com.sulake.core.window.components.IScrollableWindow;
      
      public static var IScrollbarWindow:Class = com.sulake.core.window.components.IScrollbarWindow;
      
      public static var ISelectableWindow:Class = com.sulake.core.window.components.ISelectableWindow;
      
      public static var ISelectorWindow:Class = com.sulake.core.window.components.ISelectorWindow;
      
      public static var ITabButtonWindow:Class = com.sulake.core.window.components.ITabButtonWindow;
      
      public static var ITabContentWindow:Class = com.sulake.core.window.components.ITabContentWindow;
      
      public static var ITabContextWindow:Class = com.sulake.core.window.components.ITabContextWindow;
      
      public static var ISelectorListWindow:Class = com.sulake.core.window.components.ISelectorListWindow;
      
      public static var ITextFieldWindow:Class = com.sulake.core.window.components.ITextFieldWindow;
      
      public static var ITextWindow:Class = com.sulake.core.window.components.ITextWindow;
      
      public static var IToolBarWindow:Class = com.sulake.core.window.components.IToolBarWindow;
      
      public static var UnknownVarFromICoreWindowFrameworkLib_Class_20:Class = UnknownCoreWindowEnum5;
      
      public static var UnknownVarFromICoreWindowFrameworkLib_Class_21:Class = UnknownCoreWindowEnum1;
      
      public static var UnknownVarFromICoreWindowFrameworkLib_Class_22:Class = UnknownCoreWindowEnum2;
      
      public static var UnknownVarFromICoreWindowFrameworkLib_Class_23:Class = UnknownCoreWindowEnum3;
      
      public static var UnknownVarFromICoreWindowFrameworkLib_Class_24:Class = UnknownCoreWindowEnum4;
      
      public static var UnknownVarFromICoreWindowFrameworkLib_Class_25:Class = WindowEvent;
      
      public static var WindowKeyboardEvent:Class = com.sulake.core.window.events.WindowKeyboardEvent;
      
      public static var WindowMessage:Class = com.sulake.core.window.events.WindowMessage;
      
      public static var WindowMouseEvent:Class = com.sulake.core.window.events.WindowMouseEvent;
      
      public static var IMargins:Class = com.sulake.core.window.utils.IMargins;
      
      public function ICoreWindowFrameworkLib()
      {
         super();
      }
   }
}

