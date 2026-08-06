package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.habbo.utils.UnknownHabboUtils1;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import com.sulake.habbo.window.enum.UnknownHabboWindowEnum4;
   import flash.geom.Rectangle;
   
   public class BalloonWidget implements IBalloonWidget
   {
      public static const TYPE:String = "balloon";
      
      private static const ARROW_PIVOT_KEY:String = "balloon:arrow_pivot";
      
      private static const ARROW_DISPLACEMENT_KEY:String = "balloon:arrow_displacement";
      
      private static const ARROW_ASSET_PREFIX:String = "illumina_light_balloon_arrow_";
      
      private static const ARROW_FREE_PADDING:int = 6;
      
      private static const ARROW_LENGTH:int = 6;
      
      private static const ARROW_WIDTH:int = 9;
      
      private static const ARROW_PIVOT_DEFAULT:PropertyStruct = new PropertyStruct("balloon:arrow_pivot","up, center","String",false,UnknownHabboWindowEnum4.ALL);
      
      private static const ARROW_DISPLACEMENT_DEFAULT:PropertyStruct = new PropertyStruct("balloon:arrow_displacement",0,"int");
      
      private var _disposed:Boolean;
      
      private var UnknownVarFromBalloonWidget_IWidgetWindowController_1:IWidgetWindowController;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var _settingProperties:Boolean = false;
      
      private var UnknownVarFromBalloonWidget_Boolean_1:Boolean = false;
      
      private var UnknownVarFromBalloonWidget_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromBalloonWidget_IWindowController_1_2:IWindowController_1;
      
      private var UnknownVarFromBalloonWidget_IStaticBitmapWrapperWindow_1:IStaticBitmapWrapperWindow;
      
      private var _arrowPivot:String = String(ARROW_PIVOT_DEFAULT.value);
      
      private var _arrowDisplacement:int = int(ARROW_DISPLACEMENT_DEFAULT.value);
      
      public function BalloonWidget(param1:IWidgetWindowController, param2:HabboWindowManagerComponent)
      {
         super();
         UnknownVarFromBalloonWidget_IWidgetWindowController_1 = param1;
         _windowManager = param2;
         UnknownVarFromBalloonWidget_IWindowController_1_1 = _windowManager.buildFromXML(_windowManager.assets.getAssetByName("balloon_xml").content as XML) as IWindowController_1;
         UnknownVarFromBalloonWidget_IStaticBitmapWrapperWindow_1 = UnknownVarFromBalloonWidget_IWindowController_1_1.findChildByName("bitmap") as IStaticBitmapWrapperWindow;
         UnknownVarFromBalloonWidget_IWindowController_1_2 = UnknownVarFromBalloonWidget_IWindowController_1_1.findChildByName("border") as IWindowController_1;
         syncFlags();
         UnknownVarFromBalloonWidget_IWidgetWindowController_1.addEventListener("WE_RESIZE",onChange);
         UnknownVarFromBalloonWidget_IWidgetWindowController_1.addEventListener("WE_RESIZED",onChange);
         UnknownVarFromBalloonWidget_IWindowController_1_2.addEventListener("WE_RESIZE",onChange);
         UnknownVarFromBalloonWidget_IWindowController_1_2.addEventListener("WE_RESIZED",onChange);
         UnknownVarFromBalloonWidget_IWidgetWindowController_1.rootWindow = UnknownVarFromBalloonWidget_IWindowController_1_1;
         UnknownVarFromBalloonWidget_IWindowController_1_1.width = UnknownVarFromBalloonWidget_IWidgetWindowController_1.width;
         UnknownVarFromBalloonWidget_IWindowController_1_1.height = UnknownVarFromBalloonWidget_IWidgetWindowController_1.height;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(UnknownVarFromBalloonWidget_IWindowController_1_2 != null)
            {
               UnknownVarFromBalloonWidget_IWindowController_1_2.removeEventListener("WE_RESIZE",onChange);
               UnknownVarFromBalloonWidget_IWindowController_1_2.removeEventListener("WE_RESIZED",onChange);
               UnknownVarFromBalloonWidget_IWindowController_1_2 = null;
            }
            UnknownVarFromBalloonWidget_IStaticBitmapWrapperWindow_1 = null;
            if(UnknownVarFromBalloonWidget_IWindowController_1_1 != null)
            {
               UnknownVarFromBalloonWidget_IWindowController_1_1.dispose();
               UnknownVarFromBalloonWidget_IWindowController_1_1 = null;
            }
            if(UnknownVarFromBalloonWidget_IWidgetWindowController_1 != null)
            {
               UnknownVarFromBalloonWidget_IWidgetWindowController_1.removeEventListener("WE_RESIZE",onChange);
               UnknownVarFromBalloonWidget_IWidgetWindowController_1.removeEventListener("WE_RESIZED",onChange);
               UnknownVarFromBalloonWidget_IWidgetWindowController_1.rootWindow = null;
               UnknownVarFromBalloonWidget_IWidgetWindowController_1 = null;
            }
            _windowManager = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get iterator() : IIterator
      {
         return UnknownVarFromBalloonWidget_IWindowController_1_2?.iterator;
      }
      
      public function get properties() : Array
      {
         var _loc1_:Array = [];
         if(_disposed)
         {
            return _loc1_;
         }
         _loc1_.push(ARROW_PIVOT_DEFAULT.withValue(_arrowPivot));
         _loc1_.push(ARROW_DISPLACEMENT_DEFAULT.withValue(_arrowDisplacement));
         return _loc1_;
      }
      
      public function set properties(param1:Array) : void
      {
         _settingProperties = true;
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "balloon:arrow_pivot":
                  arrowPivot = String(_loc2_.value);
                  break;
               case "balloon:arrow_displacement":
                  arrowDisplacement = int(_loc2_.value);
                  break;
            }
         }
         _settingProperties = false;
         refresh();
      }
      
      public function get arrowPivot() : String
      {
         return _arrowPivot;
      }
      
      public function set arrowPivot(param1:String) : void
      {
         _arrowPivot = param1;
         clearFlags();
         refresh();
         syncFlags();
         refresh();
      }
      
      public function get arrowDisplacement() : int
      {
         return _arrowDisplacement;
      }
      
      public function set arrowDisplacement(param1:int) : void
      {
         _arrowDisplacement = param1;
         refresh();
      }
      
      private function onChange(param1:WindowEvent) : void
      {
         refresh();
      }
      
      private function syncFlags() : void
      {
         if(UnknownVarFromBalloonWidget_IWindowController_1_2 != null)
         {
            UnknownVarFromBalloonWidget_IWindowController_1_2.setParamFlag(131072,UnknownVarFromBalloonWidget_IWidgetWindowController_1.getParamFlag(131072));
            UnknownVarFromBalloonWidget_IWindowController_1_2.setParamFlag(147456,UnknownVarFromBalloonWidget_IWidgetWindowController_1.getParamFlag(147456));
         }
      }
      
      private function clearFlags() : void
      {
         if(UnknownVarFromBalloonWidget_IWindowController_1_2 != null)
         {
            UnknownVarFromBalloonWidget_IWindowController_1_2.setParamFlag(131072,false);
            UnknownVarFromBalloonWidget_IWindowController_1_2.setParamFlag(147456,false);
         }
      }
      
      private function refresh() : void
      {
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         if(_settingProperties || UnknownVarFromBalloonWidget_Boolean_1 || _disposed || UnknownVarFromBalloonWidget_IWindowController_1_2 == null)
         {
            return;
         }
         var _loc4_:String;
         switch(_loc4_ = UnknownHabboWindowEnum4.directionFromPivot(_arrowPivot))
         {
            case "up":
            case "down":
               _loc1_ = int(UnknownVarFromBalloonWidget_IWindowController_1_2.width);
               _loc3_ = UnknownVarFromBalloonWidget_IWindowController_1_2.height + 6 - 1;
               break;
            case "left":
            case "right":
               _loc1_ = UnknownVarFromBalloonWidget_IWindowController_1_2.width + 6 - 1;
               _loc3_ = int(UnknownVarFromBalloonWidget_IWindowController_1_2.height);
         }
         UnknownVarFromBalloonWidget_Boolean_1 = true;
         if(UnknownVarFromBalloonWidget_IWidgetWindowController_1.testParamFlag(147456))
         {
            UnknownVarFromBalloonWidget_IWindowController_1_1.width = _loc1_;
            UnknownVarFromBalloonWidget_IWindowController_1_1.height = _loc3_;
         }
         else if(UnknownVarFromBalloonWidget_IWidgetWindowController_1.testParamFlag(131072))
         {
            UnknownVarFromBalloonWidget_IWindowController_1_1.width = Math.max(UnknownVarFromBalloonWidget_IWidgetWindowController_1.width,_loc1_);
            UnknownVarFromBalloonWidget_IWindowController_1_1.height = Math.max(UnknownVarFromBalloonWidget_IWidgetWindowController_1.height,_loc3_);
         }
         else
         {
            UnknownVarFromBalloonWidget_IWindowController_1_1.width = UnknownVarFromBalloonWidget_IWidgetWindowController_1.width;
            UnknownVarFromBalloonWidget_IWindowController_1_1.height = UnknownVarFromBalloonWidget_IWidgetWindowController_1.height;
         }
         UnknownVarFromBalloonWidget_IWidgetWindowController_1.width = UnknownVarFromBalloonWidget_IWindowController_1_1.width;
         UnknownVarFromBalloonWidget_IWidgetWindowController_1.height = UnknownVarFromBalloonWidget_IWindowController_1_1.height;
         UnknownVarFromBalloonWidget_Boolean_1 = false;
         UnknownVarFromBalloonWidget_IStaticBitmapWrapperWindow_1.assetUri = "illumina_light_balloon_arrow_" + _loc4_;
         switch(_loc4_)
         {
            case "up":
            case "down":
               switch(UnknownHabboWindowEnum4.positionFromPivot(_arrowPivot))
               {
                  case "minimum":
                     _loc2_ = 6;
                     break;
                  case "middle":
                     _loc2_ = (UnknownVarFromBalloonWidget_IWindowController_1_1.width - 9) / 2;
                     break;
                  case "maximum":
                     _loc2_ = UnknownVarFromBalloonWidget_IWindowController_1_1.width - 6 - 9;
               }
               UnknownVarFromBalloonWidget_Boolean_1 = true;
               UnknownVarFromBalloonWidget_IWindowController_1_2.rectangle = new Rectangle(0,_loc4_ == "up" ? 6 - 1 : 0,UnknownVarFromBalloonWidget_IWindowController_1_1.width,UnknownVarFromBalloonWidget_IWindowController_1_1.height + 1 - 6);
               UnknownVarFromBalloonWidget_Boolean_1 = false;
               UnknownVarFromBalloonWidget_IStaticBitmapWrapperWindow_1.rectangle = new Rectangle(UnknownHabboUtils1.clamp(_loc2_ + _arrowDisplacement,6,UnknownVarFromBalloonWidget_IWindowController_1_1.width - 6),_loc4_ == "up" ? 0 : UnknownVarFromBalloonWidget_IWindowController_1_2.bottom - 1,9,6);
               break;
            case "left":
            case "right":
               switch(UnknownHabboWindowEnum4.positionFromPivot(_arrowPivot))
               {
                  case "minimum":
                     _loc2_ = 6;
                     break;
                  case "middle":
                     _loc2_ = (UnknownVarFromBalloonWidget_IWindowController_1_1.height - 9) / 2;
                     break;
                  case "maximum":
                     _loc2_ = UnknownVarFromBalloonWidget_IWindowController_1_1.height - 6 - 9;
               }
               UnknownVarFromBalloonWidget_Boolean_1 = true;
               UnknownVarFromBalloonWidget_IWindowController_1_2.rectangle = new Rectangle(_loc4_ == "left" ? 6 - 1 : 0,0,UnknownVarFromBalloonWidget_IWindowController_1_1.width + 1 - 6,UnknownVarFromBalloonWidget_IWindowController_1_1.height);
               UnknownVarFromBalloonWidget_Boolean_1 = false;
               UnknownVarFromBalloonWidget_IStaticBitmapWrapperWindow_1.rectangle = new Rectangle(_loc4_ == "left" ? 0 : UnknownVarFromBalloonWidget_IWindowController_1_2.right - 1,UnknownHabboUtils1.clamp(_loc2_ + _arrowDisplacement,6,UnknownVarFromBalloonWidget_IWindowController_1_1.height - 6),6,9);
         }
      }
   }
}

