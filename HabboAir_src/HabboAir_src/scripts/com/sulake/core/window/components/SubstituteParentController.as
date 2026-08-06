package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.graphics.IGraphicContext;
   import flash.geom.Rectangle;
   
   public class SubstituteParentController extends WindowController
   {
      public static const NAME:String = "_CONTEXT_SUBSTITUTE_PARENT";
      
      public function SubstituteParentController(param1:WindowContext)
      {
         super("_CONTEXT_SUBSTITUTE_PARENT",0,0,16,param1,new Rectangle(0,0,1,1),null,null,null,null,0);
         _children = new Vector.<IWindowModel>();
         UnknownVarFromWindowController_Boolean_1 = false;
      }
      
      override public function getGraphicContext(param1:Boolean) : IGraphicContext
      {
         return null;
      }
      
      override public function setupGraphicsContext() : IGraphicContext
      {
         return null;
      }
      
      private function childParamUpdated(param1:WindowEvent) : void
      {
         var _loc2_:IWindowModel = param1.window;
         if(getChildIndex(_loc2_) != -1)
         {
            if(!_loc2_.testParamFlag(16))
            {
               _loc2_.desktop.addChild(_loc2_);
            }
         }
      }
      
      override public function addChild(param1:IWindowModel) : IWindowModel
      {
         _children.push(param1);
         return param1;
      }
      
      override public function addChildAt(param1:IWindowModel, param2:int) : IWindowModel
      {
         var _loc3_:WindowController = WindowController(param1);
         if(_loc3_.parent != null)
         {
            WindowController(_loc3_.parent).removeChild(_loc3_);
         }
         _children.splice(param2,0,param1);
         _loc3_.parent = this;
         return param1;
      }
      
      override public function getChildAt(param1:int) : IWindowModel
      {
         return !!_children ? (param1 < _children.length ? _children[param1] : null) : null;
      }
      
      override public function getChildByID(param1:int) : IWindowModel
      {
         if(_children)
         {
            for each(var _loc2_ in _children)
            {
               if(_loc2_.id == param1)
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      override public function getChildByName(param1:String) : IWindowModel
      {
         if(_children)
         {
            for each(var _loc2_ in _children)
            {
               if(_loc2_.name == param1)
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      override public function findChildByName(param1:String) : IWindowModel
      {
         var _loc2_:WindowController = null;
         if(_children)
         {
            for each(_loc2_ in _children)
            {
               if(_loc2_.name == param1)
               {
                  return _loc2_;
               }
            }
            for each(_loc2_ in _children)
            {
               _loc2_ = _loc2_.findChildByName(param1) as WindowController;
               if(_loc2_)
               {
                  return _loc2_ as IWindowModel;
               }
            }
         }
         return null;
      }
      
      override public function removeChild(param1:IWindowModel) : IWindowModel
      {
         var _loc2_:int = int(_children.indexOf(param1));
         if(_loc2_ > -1)
         {
            _children.splice(_loc2_,1);
            param1.parent = null;
            return param1;
         }
         return null;
      }
      
      override public function setChildIndex(param1:IWindowModel, param2:int) : void
      {
         var _loc3_:int = int(_children.indexOf(param1));
         if(_loc3_ > -1 && param2 != _loc3_)
         {
            _children.splice(_loc3_,1);
            _children.splice(param2,0,param1);
         }
      }
      
      override public function swapChildren(param1:IWindowModel, param2:IWindowModel) : void
      {
         var _loc3_:* = 0;
         var _loc6_:* = 0;
         var _loc5_:* = null;
         var _loc4_:* = 0;
         if(param1 != null && param2 != null && param1 != param2)
         {
            _loc3_ = int(_children.indexOf(param1));
            if(_loc3_ < 0)
            {
               return;
            }
            _loc6_ = int(_children.indexOf(param2));
            if(_loc6_ < 0)
            {
               return;
            }
            if(_loc6_ < _loc3_)
            {
               _loc5_ = param1;
               param1 = param2;
               param2 = _loc5_;
               _loc4_ = _loc3_;
               _loc3_ = _loc6_;
               _loc6_ = _loc4_;
            }
            _children.splice(_loc6_,1);
            _children.splice(_loc3_,1);
            _children.splice(_loc3_,0,param2);
            _children.splice(_loc6_,0,param1);
         }
      }
      
      override public function swapChildrenAt(param1:int, param2:int) : void
      {
         swapChildren(_children[param1],_children[param2]);
      }
   }
}

