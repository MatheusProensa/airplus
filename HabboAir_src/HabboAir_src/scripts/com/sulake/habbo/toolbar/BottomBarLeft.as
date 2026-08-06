package com.sulake.habbo.toolbar
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.localization.ILocalization;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IBoxSizerController;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.motion.Dispose;
   import com.sulake.core.window.motion.DropBounce;
   import com.sulake.core.window.motion.EaseOut;
   import com.sulake.core.window.motion.JumpBy;
   import com.sulake.core.window.motion.Motion;
   import com.sulake.core.window.motion.Motions;
   import com.sulake.core.window.motion.Queue;
   import com.sulake.core.window.motion.Wait;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils4;
   import com.sulake.habbo.catalog.event.CatalogEvent;
   import com.sulake.habbo.roomevents.events.WiredMenuEvent;
   import com.sulake.habbo.toolbar.memenu.MeMenuNewController;
   import com.sulake.habbo.toolbar.progmenu.ProgMenuController;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.display.BitmapData;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   
   public class BottomBarLeft implements ILinkEventTracker
   {
      private static const ICON_BG_COLOR_OVER:uint = 7433577;
      
      private static const ICON_BG_COLOR_OUT:uint = 5723213;
      
      private static const ICON_MOUSE_OVER:String = "_hover";
      
      private static const ICON_MOUSE_OUT:String = "_normal";
      
      private static const COUNTER_MARGIN:int = 0;
      
      private static const ME_MENU_ICON_NAME:String = "icon_me_menu";
      
      private static const ICON_REGION_WIDTH:int = 45;
      
      private static const ICON_LABEL_HEIGHT:int = 20;
      
      private static const WINDOW_RIGHT_PADDING:int = 10;
      
      private static const COLLAPSED_MARGIN:int = 185;
      
      private static const COLLAPSE_ANIMATION_DURATION_MS:int = 140;
      
      private static const COLLAPSE_ANIMATION_FPS:int = 60;
      
      private static const DEFAULT_LOCATION:Point = new Point(0,500);
      
      private static const LANDING_VIEW_LOCATION:Point = new Point(0,500);
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromBottomBarLeft_IEventDispatcher_1:IEventDispatcher;
      
      private var _disposed:Boolean;
      
      private var _toolbar:HabboToolbar;
      
      private var _assets:IAssetLibraryCollection;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _unseenItemCounters:Map;
      
      private var UnknownVarFromBottomBarLeft_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromBottomBarLeft_Boolean_1:Boolean;
      
      private var UnknownVarFromBottomBarLeft_BitmapData_1:BitmapData;
      
      private var _left_arrow:IRegionWindow;
      
      private var _right_arrow:IRegionWindow;
      
      private var _buttonContainer:IBoxSizerController;
      
      private var UnknownVarFromBottomBarLeft_IStaticBitmapWrapperWindow_1:IStaticBitmapWrapperWindow;
      
      private var _toolbarState:String;
      
      private var UnknownVarFromBottomBarLeft_Timer_1:Timer;
      
      private var UnknownVarFromBottomBarLeft_Int_1:int = 0;
      
      private var _animationStartWidth:Number = 0;
      
      private var _animationTargetWidth:int = 0;
      
      private var _animationStartAreaWidth:Number = 0;
      
      private var _animationTargetAreaWidth:int = 0;
      
      private var _currentToolbarAreaWidth:int = 0;
      
      private var _animationSourceLayout:Object;
      
      private var _animationTargetLayout:Object;
      
      private var UnknownVarFromBottomBarLeft_Boolean_2:Boolean = false;
      
      private var UnknownVarFromBottomBarLeft_Boolean_3:Boolean = false;
      
      private var UnknownVarFromBottomBarLeft_String_1:String;
      
      private var UnknownVarFromBottomBarLeft_Int_2:int;
      
      private var UnknownVarFromBottomBarLeft_Int_3:int;
      
      private var UnknownVarFromBottomBarLeft_Int_4:int;
      
      private var UnknownVarFromBottomBarLeft_Int_5:int;
      
      private var UnknownVarFromBottomBarLeft_Int_6:int;
      
      private var UnknownVarFromBottomBarLeft_Boolean_4:Boolean = false;
      
      private var _memenu:MeMenuNewController;
      
      private var _progmenu:ProgMenuController;
      
      public function BottomBarLeft(param1:HabboToolbar, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection, param4:IEventDispatcher)
      {
         var _loc5_:IWindowController_1 = null;
         super();
         _toolbar = param1;
         _windowManager = param2;
         _assets = param3;
         UnknownVarFromBottomBarLeft_IEventDispatcher_1 = param4;
         _memenu = new MeMenuNewController(_toolbar,this);
         _progmenu = new ProgMenuController(_toolbar,this);
         _unseenItemCounters = new Map();
         var _loc13_:XmlAsset = param3.getAssetByName("bottom_bar_left_xml") as XmlAsset;
         _window = param2.buildFromXML(_loc13_.content as XML) as IWindowController_1;
         if(_window == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         _window.addEventListener("WE_PARENT_RESIZED",onParentResized);
         _window.clipping = true;
         _buttonContainer = _window.getChildByName("toolbar_items") as IBoxSizerController;
         if(_buttonContainer != null)
         {
            _buttonContainer.clipping = true;
         }
         var _loc14_:IWindowController_1 = _window.getChildByName("arrow_container_left") as IWindowController_1;
         var _loc10_:IWindowController_1 = _window.getChildByName("arrow_container_right") as IWindowController_1;
         _left_arrow = _loc14_.getChildByName("collapse_left") as IRegionWindow;
         _right_arrow = _loc10_.getChildByName("collapse_right") as IRegionWindow;
         if(_left_arrow)
         {
            _left_arrow.addEventListener("WME_CLICK",onCollapseToolsBar);
         }
         if(_right_arrow)
         {
            _right_arrow.addEventListener("WME_CLICK",onCollapseToolsBar);
         }
         UnknownVarFromBottomBarLeft_IStaticBitmapWrapperWindow_1 = _buttonContainer.getChildByName("line") as IStaticBitmapWrapperWindow;
         var _loc9_:Array = [];
         _window.groupChildrenWithTag("TOGGLE",_loc9_,-1);
         for each(var _loc7_ in _loc9_)
         {
            if(_loc7_ && _loc7_ is IRegionWindow)
            {
               _loc7_.addEventListener("WME_CLICK",onIconClick);
            }
         }
         iconVisibility(HabboToolbarIconEnum.getIconName("HTIE_ICON_MEMENU"),false);
         iconVisibility(HabboToolbarIconEnum.getIconName("HTIE_ICON_INVENTORY"),false);
         iconVisibility(HabboToolbarIconEnum.getIconName("HTIE_ICON_WIRED_MENU"),false);
         var _loc12_:Boolean = param1.getBoolean("games_icon_enabled");
         if(_loc12_)
         {
            iconVisibility(HabboToolbarIconEnum.getIconName("HTIE_ICON_GAMES"),true);
         }
         else
         {
            iconVisibility(HabboToolbarIconEnum.getIconName("HTIE_ICON_GAMES"),false);
         }
         var _loc11_:XmlAsset = param3.getAssetByName("new_items_label_xml") as XmlAsset;
         UnknownVarFromBottomBarLeft_IWindowController_1_1 = param2.buildFromXML(_loc11_.content as XML,2) as IWindowController_1;
         if(UnknownVarFromBottomBarLeft_IWindowController_1_1 == null)
         {
            throw new Error("Failed to construct toolbar label from XML!");
         }
         _loc5_ = _window.findChildByName(HabboToolbarIconEnum.getIconName("HTIE_ICON_NAVIGATOR")) as IWindowController_1;
         if(_loc5_)
         {
            _windowManager.registerHintWindow(HabboToolbarIconEnum.getIconName("HTIE_ICON_NAVIGATOR"),_loc5_);
         }
         _loc5_ = _window.findChildByName(HabboToolbarIconEnum.getIconName("HTIE_ICON_MEMENU")) as IWindowController_1;
         if(_loc5_)
         {
            _windowManager.registerHintWindow(HabboToolbarIconEnum.getIconName("HTIE_ICON_MEMENU"),_loc5_);
         }
         _loc5_ = _window.findChildByName(HabboToolbarIconEnum.getIconName("HTIE_ICON_INVENTORY")) as IWindowController_1;
         if(_loc5_)
         {
            _windowManager.registerHintWindow(HabboToolbarIconEnum.getIconName("HTIE_ICON_INVENTORY"),_loc5_);
         }
         var _loc8_:IWindowController_1 = _window.findChildByName(HabboToolbarIconEnum.getIconName("HTIE_ICON_CATALOGUE")) as IWindowController_1;
         _loc8_.addChild(UnknownVarFromBottomBarLeft_IWindowController_1_1);
         _windowManager.registerHintWindow(HabboToolbarIconEnum.getIconName("HTIE_ICON_CATALOGUE"),_loc8_);
         var _loc15_:ITextWindow = UnknownVarFromBottomBarLeft_IWindowController_1_1.findChildByName("new_textfield") as ITextWindow;
         var _loc6_:ILocalization = param1.localization.getLocalizationRaw("toolbar.new_additions.notification");
         if(_loc6_ != null)
         {
            _loc15_.text = _loc6_.value;
         }
         UnknownVarFromBottomBarLeft_IWindowController_1_1.visible = false;
         UnknownVarFromBottomBarLeft_IWindowController_1_1.x = _loc8_.width - UnknownVarFromBottomBarLeft_IWindowController_1_1.width - 0;
         UnknownVarFromBottomBarLeft_IWindowController_1_1.y = 0;
         UnknownVarFromBottomBarLeft_Boolean_1 = isNewItemsNotificationEnabled();
         UnknownVarFromBottomBarLeft_Timer_1 = new Timer(1000 / 60);
         UnknownVarFromBottomBarLeft_Timer_1.addEventListener("timer",onAnimationTimer);
         checkSize();
         (param1 as Component).context.addLinkEventTracker(this);
      }
      
      private function onPanicButton(param1:WindowMouseEvent, param2:*) : void
      {
         _toolbar.toggleWindowVisibility("PANIC");
      }
      
      private function onParentResized(param1:WindowEvent) : void
      {
         checkSize();
      }
      
      private function checkSize() : void
      {
         if(!_window || !_windowManager)
         {
            return;
         }
         _left_arrow.visible = !UnknownVarFromBottomBarLeft_Boolean_4;
         _right_arrow.visible = UnknownVarFromBottomBarLeft_Boolean_4;
         _window.y = _window.desktop.height - _window.height;
         _window.width = 45 * calculateNewWidth() + 10 + 150;
         if(!UnknownVarFromBottomBarLeft_Boolean_4)
         {
            if(_memenu != null)
            {
               _memenu.reposition();
            }
            if(_progmenu != null)
            {
               _progmenu.reposition();
            }
         }
         _currentToolbarAreaWidth = computeToolbarAreaWidth();
         _window.invalidate();
      }
      
      private function computeToolbarAreaWidth() : int
      {
         if(!UnknownVarFromBottomBarLeft_IStaticBitmapWrapperWindow_1 || !UnknownVarFromBottomBarLeft_IStaticBitmapWrapperWindow_1.parent)
         {
            return 0;
         }
         return UnknownVarFromBottomBarLeft_Boolean_4 ? 185 : UnknownVarFromBottomBarLeft_IStaticBitmapWrapperWindow_1.x + UnknownVarFromBottomBarLeft_IStaticBitmapWrapperWindow_1.parent.x;
      }
      
      private function captureToggleLayout() : Object
      {
         var _loc3_:Array = [];
         var _loc1_:Object = {};
         _window.groupChildrenWithTag("TOGGLE",_loc3_,-1);
         for each(var _loc2_ in _loc3_)
         {
            if(_loc2_ != null)
            {
               _loc1_[_loc2_.name] = {
                  "visible":_loc2_.visible,
                  "x":_loc2_.x
               };
            }
         }
         if(UnknownVarFromBottomBarLeft_IStaticBitmapWrapperWindow_1 != null)
         {
            _loc1_[UnknownVarFromBottomBarLeft_IStaticBitmapWrapperWindow_1.name] = {
               "visible":UnknownVarFromBottomBarLeft_IStaticBitmapWrapperWindow_1.visible,
               "x":UnknownVarFromBottomBarLeft_IStaticBitmapWrapperWindow_1.x
            };
         }
         return _loc1_;
      }
      
      private function applyAnimatedToggleLayout(param1:Number) : void
      {
         var _loc10_:Object = null;
         var _loc12_:Object = null;
         var _loc5_:Boolean = false;
         var _loc6_:Boolean = false;
         var _loc2_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc14_:Object = null;
         var _loc4_:Object = null;
         var _loc15_:Boolean = false;
         var _loc7_:Boolean = false;
         var _loc8_:Number = NaN;
         var _loc13_:Number = NaN;
         if(_animationSourceLayout == null || _animationTargetLayout == null || _window == null)
         {
            return;
         }
         var _loc11_:Array = [];
         _window.groupChildrenWithTag("TOGGLE",_loc11_,-1);
         for each(var _loc3_ in _loc11_)
         {
            if(_loc3_ != null)
            {
               _loc10_ = _animationSourceLayout[_loc3_.name];
               _loc12_ = _animationTargetLayout[_loc3_.name];
               _loc5_ = _loc10_ != null && _loc10_.visible;
               _loc6_ = _loc12_ != null && _loc12_.visible;
               if(!_loc5_ && !_loc6_)
               {
                  _loc3_.visible = false;
                  _loc3_.blend = 1;
               }
               else
               {
                  _loc3_.visible = true;
                  _loc2_ = Number(_loc10_ != null ? _loc10_.x : (_loc12_ != null ? _loc12_.x : _loc3_.x));
                  _loc9_ = Number(_loc12_ != null ? _loc12_.x : _loc2_);
                  _loc3_.x = Math.round(_loc2_ + (_loc9_ - _loc2_) * param1);
                  if(_loc5_ && _loc6_)
                  {
                     _loc3_.blend = 1;
                  }
                  else if(_loc5_)
                  {
                     _loc3_.blend = 1 - param1;
                  }
                  else
                  {
                     _loc3_.blend = param1;
                  }
               }
            }
         }
         if(UnknownVarFromBottomBarLeft_IStaticBitmapWrapperWindow_1 != null)
         {
            _loc14_ = _animationSourceLayout[UnknownVarFromBottomBarLeft_IStaticBitmapWrapperWindow_1.name];
            _loc4_ = _animationTargetLayout[UnknownVarFromBottomBarLeft_IStaticBitmapWrapperWindow_1.name];
            _loc15_ = _loc14_ != null && _loc14_.visible;
            _loc7_ = _loc4_ != null && _loc4_.visible;
            if(!_loc15_ && !_loc7_)
            {
               UnknownVarFromBottomBarLeft_IStaticBitmapWrapperWindow_1.visible = false;
            }
            else
            {
               UnknownVarFromBottomBarLeft_IStaticBitmapWrapperWindow_1.visible = true;
               _loc8_ = Number(_loc14_ != null ? _loc14_.x : (_loc4_ != null ? _loc4_.x : UnknownVarFromBottomBarLeft_IStaticBitmapWrapperWindow_1.x));
               _loc13_ = Number(_loc4_ != null ? _loc4_.x : _loc8_);
               UnknownVarFromBottomBarLeft_IStaticBitmapWrapperWindow_1.x = int(Math.round(_loc8_ + (_loc13_ - _loc8_) * param1));
            }
         }
      }
      
      private function clearAnimatedToggleLayout() : void
      {
         if(_buttonContainer != null)
         {
            _buttonContainer.setAutoRearrange(true);
         }
         if(_window == null)
         {
            _animationSourceLayout = null;
            _animationTargetLayout = null;
            return;
         }
         var _loc2_:Array = [];
         _window.groupChildrenWithTag("TOGGLE",_loc2_,-1);
         for each(var _loc1_ in _loc2_)
         {
            if(_loc1_ != null)
            {
               _loc1_.blend = 1;
            }
         }
         _animationSourceLayout = null;
         _animationTargetLayout = null;
      }
      
      private function startCollapseAnimation(param1:int, param2:int, param3:int, param4:int, param5:Boolean = false, param6:Boolean = false, param7:String = null, param8:Object = null, param9:Object = null) : void
      {
         if(UnknownVarFromBottomBarLeft_Timer_1 == null)
         {
            if(param5 && param7 != null)
            {
               UnknownVarFromBottomBarLeft_Boolean_4 = param6;
               setToolbarState(param7);
            }
            applyAnimationFrame(param2,param4);
            return;
         }
         UnknownVarFromBottomBarLeft_Timer_1.reset();
         UnknownVarFromBottomBarLeft_Int_1 = 0;
         _animationStartWidth = param1;
         _animationTargetWidth = param2;
         _animationStartAreaWidth = param3;
         _animationTargetAreaWidth = param4;
         _animationSourceLayout = param8;
         _animationTargetLayout = param9;
         UnknownVarFromBottomBarLeft_Boolean_2 = param5;
         UnknownVarFromBottomBarLeft_Boolean_3 = param6;
         UnknownVarFromBottomBarLeft_String_1 = param7;
         if(_buttonContainer != null && param8 != null && param9 != null)
         {
            _buttonContainer.setAutoRearrange(false);
            applyAnimatedToggleLayout(0);
         }
         applyAnimationFrame(param1,param3);
         UnknownVarFromBottomBarLeft_Timer_1.start();
      }
      
      private function applyAnimationFrame(param1:int, param2:int) : void
      {
         if(_window == null)
         {
            return;
         }
         _window.width = param1;
         _currentToolbarAreaWidth = param2;
         _window.invalidate();
         if(_toolbar != null && _toolbar.roomUI != null)
         {
            _toolbar.roomUI.triggerbottomBarResize();
         }
      }
      
      private function onAnimationTimer(param1:TimerEvent) : void
      {
         if(_window == null || UnknownVarFromBottomBarLeft_Timer_1 == null)
         {
            return;
         }
         UnknownVarFromBottomBarLeft_Int_1 += int(UnknownVarFromBottomBarLeft_Timer_1.delay);
         var _loc4_:Number = Math.min(1,UnknownVarFromBottomBarLeft_Int_1 / 140);
         var _loc2_:Number = 1 - Math.pow(1 - _loc4_,3);
         var _loc5_:int = Math.round(_animationStartWidth + (_animationTargetWidth - _animationStartWidth) * _loc2_);
         var _loc3_:int = Math.round(_animationStartAreaWidth + (_animationTargetAreaWidth - _animationStartAreaWidth) * _loc2_);
         applyAnimatedToggleLayout(_loc2_);
         applyAnimationFrame(_loc5_,_loc3_);
         if(_loc4_ >= 1)
         {
            UnknownVarFromBottomBarLeft_Timer_1.stop();
            if(UnknownVarFromBottomBarLeft_Boolean_2 && UnknownVarFromBottomBarLeft_String_1 != null)
            {
               UnknownVarFromBottomBarLeft_Boolean_4 = UnknownVarFromBottomBarLeft_Boolean_3;
               setToolbarState(UnknownVarFromBottomBarLeft_String_1);
            }
            clearAnimatedToggleLayout();
            applyAnimationFrame(_animationTargetWidth,_animationTargetAreaWidth);
            UnknownVarFromBottomBarLeft_Boolean_2 = false;
            UnknownVarFromBottomBarLeft_String_1 = null;
         }
      }
      
      public function dispose() : void
      {
         if(_memenu != null)
         {
            _memenu.dispose();
            _memenu = null;
         }
         if(_progmenu != null)
         {
            _progmenu.dispose();
            _progmenu = null;
         }
         if(UnknownVarFromBottomBarLeft_BitmapData_1 != null)
         {
            UnknownVarFromBottomBarLeft_BitmapData_1.dispose();
            UnknownVarFromBottomBarLeft_BitmapData_1 = null;
         }
         if(_unseenItemCounters != null)
         {
            _unseenItemCounters.dispose();
            _unseenItemCounters = null;
         }
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         if(UnknownVarFromBottomBarLeft_IWindowController_1_1 != null)
         {
            UnknownVarFromBottomBarLeft_IWindowController_1_1.dispose();
            UnknownVarFromBottomBarLeft_IWindowController_1_1 = null;
         }
         if(UnknownVarFromBottomBarLeft_Timer_1 != null)
         {
            UnknownVarFromBottomBarLeft_Timer_1.removeEventListener("timer",onAnimationTimer);
            UnknownVarFromBottomBarLeft_Timer_1.stop();
            UnknownVarFromBottomBarLeft_Timer_1 = null;
         }
         clearAnimatedToggleLayout();
         if(_windowManager)
         {
            _windowManager.unregisterHintWindow(HabboToolbarIconEnum.getIconName("HTIE_ICON_NAVIGATOR"));
            _windowManager.unregisterHintWindow(HabboToolbarIconEnum.getIconName("HTIE_ICON_MEMENU"));
            _windowManager.unregisterHintWindow(HabboToolbarIconEnum.getIconName("HTIE_ICON_INVENTORY"));
            _windowManager.unregisterHintWindow(HabboToolbarIconEnum.getIconName("HTIE_ICON_CATALOGUE"));
         }
         if(_toolbar)
         {
            (_toolbar as Component).context.removeLinkEventTracker(this);
            _toolbar = null;
         }
         _windowManager = null;
         _assets = null;
         _disposed = true;
         if(UnknownVarFromBottomBarLeft_IEventDispatcher_1)
         {
            UnknownVarFromBottomBarLeft_IEventDispatcher_1 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get window() : IWindowModel
      {
         return _window;
      }
      
      private function disableCatalogIcon() : void
      {
         var _loc1_:IWindowController_1 = _window.findChildByName(HabboToolbarIconEnum.getIconName("HTIE_ICON_CATALOGUE")) as IWindowController_1;
         _loc1_.blend = 0.5;
         _loc1_.disable();
      }
      
      public function onCatalogEvent(param1:CatalogEvent) : void
      {
         var _loc2_:IWindowController_1 = null;
         var _loc3_:String = null;
         switch(param1.type)
         {
            case "CATALOG_INITIALIZED":
               _loc2_ = _window.findChildByName(HabboToolbarIconEnum.getIconName("HTIE_ICON_CATALOGUE")) as IWindowController_1;
               _loc2_.blend = 1;
               _loc2_.enable();
               _loc3_ = _toolbar.getProperty("open.catalog.page");
               if(_loc3_.length > 0 && _toolbar.catalog)
               {
                  _toolbar.catalog.openCatalogPage("hc_membership");
                  _toolbar.setProperty("open.catalog.page","");
               }
               break;
            case "CATALOG_NOT_READY":
               disableCatalogIcon();
               break;
            case "CATALOG_NEW_ITEMS_SHOW":
               if(UnknownVarFromBottomBarLeft_IWindowController_1_1 != null && UnknownVarFromBottomBarLeft_Boolean_1)
               {
                  UnknownVarFromBottomBarLeft_IWindowController_1_1.visible = true;
               }
               break;
            case "CATALOG_NEW_ITEMS_HIDE":
               if(UnknownVarFromBottomBarLeft_IWindowController_1_1 != null)
               {
                  UnknownVarFromBottomBarLeft_IWindowController_1_1.visible = false;
               }
         }
      }
      
      public function onWiredMenuEvent(param1:WiredMenuEvent) : void
      {
         var _loc2_:IWindowController_1 = null;
         var _loc3_:* = param1.type;
         if("WIRED_MENU_BUTTON_PREFERENCE_CHANGED" === _loc3_)
         {
            _loc2_ = _window.findChildByName(HabboToolbarIconEnum.getIconName("HTIE_ICON_WIRED_MENU")) as IWindowController_1;
            _loc2_.visible = _toolbar.roomEvents != null && _toolbar.roomEvents.showToolbarMenuButton();
         }
         checkSize();
      }
      
      public function getToolbarState() : String
      {
         return _toolbarState;
      }
      
      public function setToolbarState(param1:String) : void
      {
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc6_:Boolean = false;
         if(param1 == "HTE_STATE_HIDDEN")
         {
            _window.visible = false;
            return;
         }
         _window.visible = true;
         if(param1 != "HTE_STATE_COLLAPSED")
         {
            _toolbarState = param1;
         }
         var _loc7_:Array = [];
         _window.groupChildrenWithTag("TOGGLE",_loc7_,-1);
         switch(param1)
         {
            case "HTE_STATE_GAME_CENTER_VIEW":
               _loc3_ = "VISIBLE_GAME_CENTER";
               _window.position = DEFAULT_LOCATION;
               break;
            case "HTE_STATE_HOTEL_VIEW":
               _loc3_ = "VISIBLE_HOTEL";
               _window.position = LANDING_VIEW_LOCATION;
               break;
            case "HTE_STATE_NOOB_NOT_HOME":
               _loc3_ = "VISIBLE_NOOB";
               _window.position = DEFAULT_LOCATION;
               break;
            case "HETE_STATE_NOOB_HOME":
               _loc3_ = "VISIBLE_ROOM";
               _window.position = DEFAULT_LOCATION;
               break;
            case "HTE_STATE_ROOM_VIEW":
               _loc3_ = "VISIBLE_ROOM";
               _window.position = DEFAULT_LOCATION;
               break;
            case "HTE_STATE_COLLAPSED":
               _loc3_ = "VISIBLE_COLLAPSED";
               _window.position = DEFAULT_LOCATION;
         }
         var _loc4_:Boolean = param1 == "HTE_STATE_ROOM_VIEW" || param1 == "HETE_STATE_NOOB_HOME" || param1 == "HTE_STATE_NOOB_NOT_HOME" || UnknownVarFromBottomBarLeft_Boolean_4 && (_toolbarState == "HTE_STATE_ROOM_VIEW" || _toolbarState == "HETE_STATE_NOOB_HOME" || _toolbarState == "HTE_STATE_NOOB_NOT_HOME");
         for each(var _loc2_ in _loc7_)
         {
            if(_loc2_)
            {
               _loc2_.visible = _loc2_.tags.indexOf(_loc3_) >= 0;
               if(_loc2_.name == "STORIES" && !UnknownVarFromBottomBarLeft_Boolean_4)
               {
                  _loc2_.visible &&= _toolbar.getBoolean("toolbar.stories.enabled");
               }
               else if(_loc2_.name == "BUILDER" && !UnknownVarFromBottomBarLeft_Boolean_4)
               {
                  _loc2_.visible &&= _toolbar.getBoolean("builders.club.enabled");
               }
               else if(_loc2_.name == "GAMES")
               {
                  _loc2_.visible &&= _toolbar.getBoolean("games_icon_enabled");
               }
               else if(_loc2_.name == "CAMERA")
               {
                  _loc5_ = _toolbar.getProperty("camera.launch.ui.position");
                  _loc6_ = _toolbar.sessionDataManager.isPerkAllowed("CAMERA");
                  _loc2_.visible &&= _loc4_ && _loc5_ == "bottom-icons" && _loc6_;
               }
               else if(_loc2_.name == "WIRED_MENU")
               {
                  _loc2_.visible &&= _loc4_ && _toolbar.roomEvents != null && _toolbar.roomEvents.showToolbarMenuButton();
               }
            }
         }
         checkSize();
      }
      
      public function iconVisibility(param1:String, param2:Boolean) : void
      {
         var _loc3_:IWindowController_1 = _window.findChildByName(param1) as IWindowController_1;
         if(_loc3_)
         {
            _loc3_.visible = param2;
         }
         checkSize();
      }
      
      public function calculateNewWidth() : int
      {
         var _loc3_:Array = [];
         var _loc2_:int = 1;
         _window.groupChildrenWithTag("TOGGLE",_loc3_,-1);
         for each(var _loc1_ in _loc3_)
         {
            if(_loc1_ && _loc1_.visible)
            {
               _loc2_++;
            }
         }
         return _loc2_;
      }
      
      private function onNaviHover(param1:WindowMouseEvent) : void
      {
         var _loc2_:Rectangle = null;
         if(_toolbar.navigator == null)
         {
            return;
         }
         switch(param1.type)
         {
            case "WME_OVER":
               _loc2_ = getIconLocation("HTIE_ICON_NAVIGATOR");
               _toolbar.navigator.showToolbarHover(new Point(_loc2_.right + 15,_loc2_.y));
               break;
            case "WME_OUT":
               _toolbar.navigator.hideToolbarHover(true);
         }
      }
      
      private function onIconHoverMouseEvent(param1:WindowMouseEvent) : void
      {
         var _loc2_:IWindowController_1 = param1.target as IWindowController_1;
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:UnknownICoreWindowComponents6 = _loc2_.findChildByTag("ICON_BORDER") as UnknownICoreWindowComponents6;
         var _loc4_:UnknownICoreWindowUtils4 = _loc2_.findChildByTag("ICON_BMP") as UnknownICoreWindowUtils4;
         Logger.log(param1);
         switch(param1.type)
         {
            case "WME_OVER":
               setIconHoverState(_loc4_,"_hover");
               setIconBgHoverState(_loc3_,"_hover");
               if(param1.target.name == "NAVIGATOR")
               {
                  onNaviHover(param1);
               }
               break;
            case "WME_OUT":
               setIconHoverState(_loc4_,"_normal");
               setIconBgHoverState(_loc3_,"_normal");
               if(param1.target.name == "NAVIGATOR")
               {
                  onNaviHover(param1);
               }
         }
      }
      
      private function setIconHoverState(param1:UnknownICoreWindowUtils4, param2:String) : void
      {
         var _loc3_:IStaticBitmapWrapperWindow = null;
         var _loc4_:IBitmapWrapperController = null;
         if(param1 is IStaticBitmapWrapperWindow)
         {
            _loc3_ = param1 as IStaticBitmapWrapperWindow;
            _loc3_.assetUri = _loc3_.name + param2;
         }
         else if(param1 is IBitmapWrapperController)
         {
            _loc4_ = param1 as IBitmapWrapperController;
            if(_loc4_.name == "icon_me_menu")
            {
               _loc4_.bitmap = UnknownVarFromBottomBarLeft_BitmapData_1;
            }
         }
      }
      
      private function setIconBgHoverState(param1:IWindowController_1, param2:String) : void
      {
         if(!param1)
         {
            return;
         }
         if(param2 == "_hover")
         {
            param1.color = 7433577;
         }
         else
         {
            param1.color = 5723213;
         }
      }
      
      private function onIconClick(param1:WindowMouseEvent) : void
      {
         var _loc2_:String = IWindowModel(param1.target).name;
         _toolbar.toggleWindowVisibility(_loc2_);
         _windowManager.hideMatchingHint(_loc2_);
      }
      
      public function setIconBitmap(param1:String, param2:BitmapData) : void
      {
         var _loc3_:String = null;
         if(!param2)
         {
            return;
         }
         var _loc5_:* = param1;
         if("HTIE_ICON_MEMENU" === _loc5_)
         {
            _loc3_ = "icon_me_menu";
            setMeMenuIconBitmaps(param2);
         }
         var _loc4_:UnknownICoreWindowUtils4 = _window.findChildByName(_loc3_) as UnknownICoreWindowUtils4;
         if(_loc4_ != null)
         {
            setIconHoverState(_loc4_,"_normal");
         }
      }
      
      private function getIconName(param1:String) : String
      {
         var _loc2_:String = null;
         switch(param1)
         {
            case "HTIE_ICON_CATALOGUE":
               _loc2_ = "icons_toolbar_catalogue";
               break;
            case "HTIE_ICON_INVENTORY":
               _loc2_ = "icons_toolbar_inventory";
               break;
            case "HTIE_ICON_MEMENU":
               _loc2_ = "MEMENU";
               break;
            case "HTIE_ICON_NAVIGATOR":
               _loc2_ = "icons_toolbar_navigator";
               break;
            case "HTIE_ICON_PROGRESSION":
               _loc2_ = "icons_toolbar_progression";
               break;
            case "HTIE_ICON_GAMES":
               _loc2_ = "icons_toolbar_games";
               break;
            case "HTIE_ICON_STORIES":
               _loc2_ = "icons_toolbar_stories";
               break;
            case "HTIE_ICON_RECEPTION":
               _loc2_ = "icons_toolbar_reception";
               break;
            case "HTIE_ICON_BUILDER":
               _loc2_ = "icons_toolbar_builder";
               break;
            case "HTIE_ICON_CAMERA":
               _loc2_ = "icons_toolbar_camera";
               break;
            case "HTIE_ICON_WIRED_MENU":
               _loc2_ = "icons_toolbar_wired_menu";
         }
         return _loc2_;
      }
      
      public function getIconLocation(param1:String) : Rectangle
      {
         var _loc4_:IWindowModel = null;
         var _loc2_:Rectangle = new Rectangle();
         var _loc5_:String = null;
         _loc5_ = getIconName(param1);
         if(_loc5_ != null)
         {
            _loc4_ = _window.findChildByName(_loc5_);
         }
         if(_loc4_ != null && _loc4_.visible)
         {
            _loc4_.getGlobalRectangle(_loc2_);
            return _loc2_;
         }
         var _loc3_:Rectangle = _memenu.getIconPosition(param1);
         if(_loc3_ != null)
         {
            return _loc3_;
         }
         _loc3_ = _progmenu.getIconPosition(param1);
         if(_loc3_ != null)
         {
            return _loc3_;
         }
         return null;
      }
      
      public function geIcon(param1:String) : IWindowModel
      {
         var _loc3_:IWindowModel = null;
         var _loc2_:String = getIconName(param1);
         _loc3_ = _window.findChildByName(_loc2_);
         if(!_loc3_)
         {
            _loc3_ = _memenu.getIcon(param1);
         }
         if(!_loc3_)
         {
            _loc3_ = _progmenu.getIcon(param1);
         }
         return _loc3_;
      }
      
      private function setMeMenuIconBitmaps(param1:BitmapData) : void
      {
         if(UnknownVarFromBottomBarLeft_BitmapData_1 != null)
         {
            UnknownVarFromBottomBarLeft_BitmapData_1.dispose();
         }
         if(param1 != null)
         {
            UnknownVarFromBottomBarLeft_BitmapData_1 = param1.clone();
         }
         param1.dispose();
      }
      
      public function setUnseenItemCount(param1:String, param2:int) : void
      {
         var _loc3_:IWindowController_1 = getUnseenItemCounter(param1);
         if(!_loc3_)
         {
            return;
         }
         if(param2 < 0)
         {
            _loc3_.visible = true;
            _loc3_.findChildByName("count").caption = " ";
         }
         else if(param2 > 0)
         {
            _loc3_.visible = true;
            _loc3_.findChildByName("count").caption = param2.toString();
         }
         else
         {
            _loc3_.visible = false;
         }
      }
      
      public function getUnseenItemCounter(param1:String) : IWindowController_1
      {
         var _loc2_:IWindowController_1 = null;
         var _loc4_:String = HabboToolbarIconEnum.getIconName(param1);
         if(!_loc4_)
         {
            Logger.log("[Toolbar] Unknown icon type for unseen item counter for iconId: " + param1);
         }
         var _loc3_:IWindowController_1 = _unseenItemCounters.getValue(param1) as IWindowController_1;
         if(!_loc3_)
         {
            _loc3_ = _windowManager.createUnseenItemCounter();
            _loc2_ = _window.findChildByName(_loc4_) as IWindowController_1;
            if(_loc2_)
            {
               if(param1 == "HTIE_ICON_MEMENU")
               {
                  _loc3_.setParamFlag(16,false);
               }
               _loc2_.addChild(_loc3_);
               _loc3_.x = _loc2_.width - _loc3_.width - 0;
               _loc3_.y = 0;
               _unseenItemCounters.add(param1,_loc3_);
            }
         }
         return _loc3_;
      }
      
      public function isNewItemsNotificationEnabled() : Boolean
      {
         return _toolbar.getBoolean("toolbar.new_additions.notification.enabled");
      }
      
      public function animateToIcon(param1:String, param2:BitmapData, param3:int, param4:int) : Motion
      {
         var _loc14_:IWindowModel = null;
         var _loc11_:int = 20;
         var _loc16_:int = !!param2 ? param2.width : _loc11_;
         var _loc19_:int = !!param2 ? param2.height : _loc11_;
         var _loc18_:IBitmapWrapperController = _windowManager.create("ToolBarTransition",21,0,0,new Rectangle(param3,param4,_loc16_,_loc19_)) as IBitmapWrapperController;
         if(param2)
         {
            _loc18_.bitmap = param2;
            _loc18_.disposesBitmap = true;
            _loc18_.filters = [new GlowFilter(16777215,1,2,2,255,1,false,false)];
         }
         _windowManager.getDesktop(2).addChild(_loc18_);
         var _loc7_:String = null;
         _loc7_ = getIconName(param1);
         if(_loc7_ != null)
         {
            _loc14_ = _window.findChildByName(_loc7_);
         }
         if(!_loc14_)
         {
            _loc18_.dispose();
            return null;
         }
         var _loc12_:Rectangle = new Rectangle();
         _loc18_.getGlobalRectangle(_loc12_);
         var _loc10_:Rectangle = new Rectangle();
         _loc14_.getGlobalRectangle(_loc10_);
         var _loc13_:int = _loc12_.x - _loc10_.x;
         var _loc15_:int = _loc12_.y - _loc10_.y;
         var _loc5_:Number = Math.sqrt(_loc13_ * _loc13_ + _loc15_ * _loc15_);
         var _loc8_:int = 500 - Math.abs(1 / _loc5_ * 100 * 500 * 0.5);
         var _loc9_:int = 20;
         var _loc17_:String = "ToolBarBouncing[ " + _loc7_ + " ]";
         if(!Motions.getMotionByTag(_loc17_))
         {
            Motions.runMotion(new Queue(new Wait(_loc8_ + 8),new DropBounce(_loc14_,400,12))).tag = _loc17_;
         }
         var _loc6_:Motion = new Queue(new EaseOut(new JumpBy(_loc18_,_loc8_,_loc10_.x - _loc12_.x + _loc9_,_loc10_.y - _loc12_.y,100,1),1),new Dispose(_loc18_));
         return Motions.runMotion(_loc6_);
      }
      
      public function set onDuty(param1:Boolean) : void
      {
         var _loc2_:IWindowModel = _window.findChildByName("guide_icon");
         if(_loc2_ != null)
         {
            _loc2_.visible = param1;
         }
      }
      
      public function set unseenAchievementCount(param1:int) : void
      {
         UnknownVarFromBottomBarLeft_Int_3 = param1;
      }
      
      public function set unseenDailyTasksCount(param1:int) : void
      {
         UnknownVarFromBottomBarLeft_Int_4 = param1;
      }
      
      public function set unseenRewardTrackRewardsCount(param1:int) : void
      {
         UnknownVarFromBottomBarLeft_Int_5 = param1;
      }
      
      public function set unseenMiniMailMessageCount(param1:int) : void
      {
         UnknownVarFromBottomBarLeft_Int_2 = param1;
      }
      
      public function set unseenForumsCount(param1:int) : void
      {
         UnknownVarFromBottomBarLeft_Int_6 = param1;
      }
      
      public function get unseenMeMenuCount() : int
      {
         return UnknownVarFromBottomBarLeft_Int_2 + UnknownVarFromBottomBarLeft_Int_6;
      }
      
      public function get unseenProgMenuCount() : int
      {
         return UnknownVarFromBottomBarLeft_Int_3 + UnknownVarFromBottomBarLeft_Int_4 + UnknownVarFromBottomBarLeft_Int_5;
      }
      
      public function get memenu() : MeMenuNewController
      {
         return _memenu;
      }
      
      public function get progmenu() : ProgMenuController
      {
         return _progmenu;
      }
      
      public function get linkPattern() : String
      {
         return "toolbar/";
      }
      
      private function onCollapseToolsBar(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromBottomBarLeft_Timer_1 != null && UnknownVarFromBottomBarLeft_Timer_1.running)
         {
            return;
         }
         var _loc3_:int = int(!!_window ? _window.width : 0);
         var _loc8_:int = _currentToolbarAreaWidth;
         var _loc2_:String = _toolbarState ?? "HTE_STATE_ROOM_VIEW";
         var _loc6_:Boolean = UnknownVarFromBottomBarLeft_Boolean_4;
         var _loc9_:String = _loc6_ ? "HTE_STATE_COLLAPSED" : _loc2_;
         var _loc7_:* = !_loc6_;
         var _loc4_:String = _loc7_ ? "HTE_STATE_COLLAPSED" : _loc2_;
         var _loc11_:Object = captureToggleLayout();
         UnknownVarFromBottomBarLeft_Boolean_4 = _loc7_;
         setToolbarState(_loc4_);
         var _loc12_:int = int(!!_window ? _window.width : 0);
         var _loc10_:int = _currentToolbarAreaWidth;
         var _loc5_:Object = captureToggleLayout();
         UnknownVarFromBottomBarLeft_Boolean_4 = _loc6_;
         setToolbarState(_loc9_);
         startCollapseAnimation(_loc3_,_loc12_,_loc8_,_loc10_,true,_loc7_,_loc4_,_loc11_,_loc5_);
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 2)
         {
            return;
         }
         switch(_loc2_[1])
         {
            case "memenu":
               memenu.toggleVisibility();
               break;
            case "highlight":
               if(_loc2_.length <= 2)
               {
                  return;
               }
               switch(_loc2_[2])
               {
                  case "catalog":
                     _windowManager.showHint(HabboToolbarIconEnum.getIconName("HTIE_ICON_CATALOGUE"));
                     break;
                  case "navigator":
                     _windowManager.showHint(HabboToolbarIconEnum.getIconName("HTIE_ICON_NAVIGATOR"));
                     break;
                  case "memenu":
                     _windowManager.showHint(HabboToolbarIconEnum.getIconName("HTIE_ICON_MEMENU"));
               }
               break;
            default:
               Logger.log("Toolbar unknown link-type received: " + _loc2_[1]);
         }
      }
      
      public function getToolbarAreaWidth() : int
      {
         if(!UnknownVarFromBottomBarLeft_IStaticBitmapWrapperWindow_1 || !UnknownVarFromBottomBarLeft_IStaticBitmapWrapperWindow_1.parent)
         {
            return 0;
         }
         return _currentToolbarAreaWidth;
      }
   }
}

