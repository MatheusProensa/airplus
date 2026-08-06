package com.sulake.habbo.avatar
{
   import com.sulake.core.assets.AssetLibraryCollection;
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.runtime.events.EventDispatcherWrapper;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.avatar.actions.ActionDefinition;
   import com.sulake.habbo.avatar.actions.AvatarActionManager;
   import com.sulake.habbo.avatar.actions.IActionDefinition;
   import com.sulake.habbo.avatar.actions.IActiveActionData;
   import com.sulake.habbo.avatar.animation.AddDataContainer;
   import com.sulake.habbo.avatar.animation.Animation;
   import com.sulake.habbo.avatar.animation.AnimationLayerData;
   import com.sulake.habbo.avatar.animation.AnimationManager;
   import com.sulake.habbo.avatar.enum.AvatarDirectionAngle;
   import com.sulake.habbo.avatar.geometry.AvatarModelGeometry;
   import com.sulake.habbo.avatar.geometry.GeometryBodyPart;
   import com.sulake.habbo.avatar.geometry.GeometryItem;
   import com.sulake.habbo.avatar.structure.*;
   import com.sulake.habbo.avatar.structure.animation.AnimationAction;
   import com.sulake.habbo.avatar.structure.animation.AnimationActionPart;
   import com.sulake.habbo.avatar.structure.figure.IFigurePart;
   import com.sulake.habbo.avatar.structure.figure.IFigurePartSet;
   import com.sulake.habbo.avatar.structure.figure.IPalette;
   import com.sulake.habbo.avatar.structure.figure.IPartColor;
   import com.sulake.habbo.avatar.structure.figure.ISetType;
   import com.sulake.habbo.avatar.structure.parts.PartDefinition;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Stage;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   
   public class AvatarStructure extends EventDispatcherWrapper
   {
      private var _renderManager:AvatarRenderManager;
      
      private var _geometry:AvatarModelGeometry;
      
      private var UnknownVarFromAvatarStructure_AvatarActionManager_1:AvatarActionManager;
      
      private var _figureData:FigureSetData;
      
      private var UnknownVarFromAvatarStructure_PartSetsData_1:PartSetsData;
      
      private var UnknownVarFromAvatarStructure_AnimationData_1:AnimationData;
      
      private var _animationManager:AnimationManager;
      
      private var _defaultAction:ActionDefinition;
      
      private var _defaultLayActionDefinition:ActionDefinition;
      
      private var UnknownVarFromAvatarStructure_Dictionary_1:Dictionary;
      
      public function AvatarStructure(param1:AvatarRenderManager)
      {
         super();
         _renderManager = param1;
         _figureData = new FigureSetData();
         UnknownVarFromAvatarStructure_PartSetsData_1 = new PartSetsData();
         UnknownVarFromAvatarStructure_AnimationData_1 = new AnimationData();
         _animationManager = new AnimationManager();
         UnknownVarFromAvatarStructure_Dictionary_1 = new Dictionary();
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            super.dispose();
            _renderManager = null;
            _figureData = null;
            UnknownVarFromAvatarStructure_PartSetsData_1 = null;
            UnknownVarFromAvatarStructure_AnimationData_1 = null;
            UnknownVarFromAvatarStructure_Dictionary_1 = null;
         }
      }
      
      public function init() : void
      {
         UnknownVarFromAvatarStructure_Dictionary_1 = new Dictionary();
      }
      
      public function initGeometry(param1:XML) : void
      {
         if(!param1)
         {
            return;
         }
         _geometry = new AvatarModelGeometry(param1);
      }
      
      public function initActions(param1:IAssetLibraryCollection, param2:XML) : void
      {
         if(!param2)
         {
            return;
         }
         UnknownVarFromAvatarStructure_AvatarActionManager_1 = new AvatarActionManager(param1,param2);
         _defaultAction = UnknownVarFromAvatarStructure_AvatarActionManager_1.getDefaultAction();
         _defaultLayActionDefinition = UnknownVarFromAvatarStructure_AvatarActionManager_1.getDefaultLayAction();
      }
      
      public function updateActions(param1:XML) : void
      {
         UnknownVarFromAvatarStructure_AvatarActionManager_1.updateActions(param1);
         _defaultAction = UnknownVarFromAvatarStructure_AvatarActionManager_1.getDefaultAction();
         _defaultLayActionDefinition = UnknownVarFromAvatarStructure_AvatarActionManager_1.getDefaultLayAction();
      }
      
      public function initPartSets(param1:XML) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         if(UnknownVarFromAvatarStructure_PartSetsData_1.parse(param1))
         {
            UnknownVarFromAvatarStructure_PartSetsData_1.getPartDefinition("ri").appendToFigure = true;
            UnknownVarFromAvatarStructure_PartSetsData_1.getPartDefinition("li").appendToFigure = true;
            return true;
         }
         return false;
      }
      
      public function initAnimation(param1:XML) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         return UnknownVarFromAvatarStructure_AnimationData_1.parse(param1);
      }
      
      public function initFigureData(param1:XML) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         return _figureData.parse(param1);
      }
      
      public function injectFigureData(param1:XML) : void
      {
         _figureData.injectXML(param1);
      }
      
      public function registerAnimations(param1:AssetLibraryCollection, param2:String = "fx", param3:int = 200) : void
      {
         var _loc4_:XML = null;
         var _loc5_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < param3)
         {
            if(param1.hasAsset(param2 + _loc5_))
            {
               _loc4_ = param1.getAssetByName(param2 + _loc5_).content as XML;
               _animationManager.registerAnimation(this,_loc4_);
            }
            _loc5_++;
         }
      }
      
      public function registerAnimation(param1:XML) : void
      {
         _animationManager.registerAnimation(this,param1);
      }
      
      public function getPartColor(param1:IAvatarFigureContainer, param2:String, param3:int = 0) : IPartColor
      {
         var _loc4_:Array = param1.getPartColorIds(param2);
         if(!_loc4_ || _loc4_.length < param3)
         {
            return null;
         }
         var _loc6_:ISetType = _figureData.getSetType(param2);
         if(_loc6_ == null)
         {
            return null;
         }
         var _loc5_:IPalette = _figureData.getPalette(_loc6_.paletteID);
         if(!_loc5_)
         {
            return null;
         }
         return _loc5_.getColor(_loc4_[param3]);
      }
      
      public function getBodyPartData(param1:String, param2:int, param3:String) : AnimationLayerData
      {
         return _animationManager.getLayerData(param1,param2,param3) as AnimationLayerData;
      }
      
      public function getAnimation(param1:String) : Animation
      {
         return _animationManager.getAnimation(param1) as Animation;
      }
      
      public function getActionDefinition(param1:String) : ActionDefinition
      {
         return UnknownVarFromAvatarStructure_AvatarActionManager_1.getActionDefinition(param1);
      }
      
      public function getDefaultActionDefinition() : ActionDefinition
      {
         return _defaultAction;
      }
      
      public function getDefaultLayActionDefinition() : ActionDefinition
      {
         return _defaultLayActionDefinition;
      }
      
      public function getActionDefinitionWithState(param1:String) : ActionDefinition
      {
         return UnknownVarFromAvatarStructure_AvatarActionManager_1.getActionDefinitionWithState(param1);
      }
      
      public function isMainAvatarSet(param1:String) : Boolean
      {
         return _geometry.isMainAvatarSet(param1);
      }
      
      public function sortActions(param1:Array) : Array
      {
         return UnknownVarFromAvatarStructure_AvatarActionManager_1.sortActions(param1);
      }
      
      public function maxFrames(param1:Array) : int
      {
         var _loc2_:int = 0;
         for each(var _loc3_ in param1)
         {
            _loc2_ = Math.max(_loc2_,UnknownVarFromAvatarStructure_AnimationData_1.getFrameCount(_loc3_.definition));
         }
         return _loc2_;
      }
      
      public function getMandatorySetTypeIds(param1:String, param2:int) : Array
      {
         if(!UnknownVarFromAvatarStructure_Dictionary_1[param1])
         {
            UnknownVarFromAvatarStructure_Dictionary_1[param1] = new Dictionary();
         }
         if(UnknownVarFromAvatarStructure_Dictionary_1[param1][param2])
         {
            return UnknownVarFromAvatarStructure_Dictionary_1[param1][param2];
         }
         UnknownVarFromAvatarStructure_Dictionary_1[param1][param2] = _figureData.getMandatorySetTypeIds(param1,param2);
         return UnknownVarFromAvatarStructure_Dictionary_1[param1][param2];
      }
      
      public function getDefaultPartSet(param1:String, param2:String) : IFigurePartSet
      {
         return _figureData.getDefaultPartSet(param1,param2);
      }
      
      public function getCanvasOffsets(param1:Array, param2:String, param3:int) : Array
      {
         return UnknownVarFromAvatarStructure_AvatarActionManager_1.getCanvasOffsets(param1,param2,param3);
      }
      
      public function getCanvas(param1:String, param2:String) : AvatarCanvas
      {
         return _geometry.getCanvas(param1,param2);
      }
      
      public function removeDynamicItems(param1:IAvatarImage_2) : void
      {
         _geometry.removeDynamicItems(param1);
      }
      
      public function getActiveBodyPartIds(param1:IActiveActionData, param2:IAvatarImage_2) : Array
      {
         var _loc8_:GeometryBodyPart = null;
         var _loc4_:String = null;
         var _loc9_:Animation = null;
         var _loc10_:GeometryBodyPart = null;
         var _loc16_:PartDefinition = null;
         var _loc14_:XML = null;
         var _loc11_:XML = null;
         var _loc13_:Array = [];
         var _loc7_:Array = [];
         var _loc15_:String = param1.definition.geometryType;
         if(param1.definition.isAnimation)
         {
            _loc4_ = param1.definition.state + "." + param1.actionParameter;
            _loc9_ = _animationManager.getAnimation(_loc4_) as Animation;
            if(_loc9_ != null)
            {
               _loc13_ = _loc9_.getAnimatedBodyPartIds(0,param1.overridingAction);
               for each(var _loc5_ in _loc9_.removeData)
               {
                  _loc10_ = _geometry.getBodyPartOfItem(_loc15_,_loc5_,param2);
                  if(_loc10_ != null)
                  {
                     if(_loc7_.indexOf(_loc10_.id) == -1)
                     {
                        _loc7_.push(_loc10_.id);
                     }
                  }
               }
               if(_loc9_.hasAddData())
               {
                  _loc14_ = <item id="" x="0" y="0" z="0" radius="0.01" nx="0" ny="0" nz="-1" double="1" />;
                  _loc11_ = <part />;
                  for each(var _loc3_ in _loc9_.addData)
                  {
                     _loc8_ = _geometry.getBodyPart(_loc15_,_loc3_.align);
                     if(_loc8_ != null)
                     {
                        _loc14_.@id = _loc3_.id;
                        _loc8_.addPart(_loc14_,param2);
                        _loc11_["set-type"] = _loc3_.id;
                        _loc16_ = UnknownVarFromAvatarStructure_PartSetsData_1.addPartDefinition(_loc11_);
                        _loc16_.appendToFigure = true;
                        if(_loc3_.base == "")
                        {
                           _loc16_.staticId = 1;
                        }
                        if(_loc7_.indexOf(_loc8_.id) == -1)
                        {
                           _loc7_.push(_loc8_.id);
                        }
                     }
                  }
               }
            }
            for each(var _loc12_ in _loc13_)
            {
               _loc8_ = _geometry.getBodyPart(_loc15_,_loc12_);
               if(_loc8_ != null)
               {
                  if(_loc7_.indexOf(_loc8_.id) == -1)
                  {
                     _loc7_.push(_loc8_.id);
                  }
               }
            }
         }
         else
         {
            _loc13_ = UnknownVarFromAvatarStructure_PartSetsData_1.getActiveParts(param1.definition);
            for each(var _loc6_ in _loc13_)
            {
               _loc8_ = _geometry.getBodyPartOfItem(_loc15_,_loc6_,param2);
               if(_loc8_ != null)
               {
                  if(_loc7_.indexOf(_loc8_.id) == -1)
                  {
                     _loc7_.push(_loc8_.id);
                  }
               }
            }
         }
         return _loc7_;
      }
      
      public function getBodyPartsUnordered(param1:String) : Array
      {
         return _geometry.getBodyPartIdsInAvatarSet(param1);
      }
      
      public function getBodyParts(param1:String, param2:String, param3:int) : Array
      {
         var _loc4_:Number = Number(AvatarDirectionAngle.UnknownConstFromAvatarDirectionAngle_Array_1[param3]);
         return _geometry.getBodyPartsAtAngle(param1,_loc4_,param2);
      }
      
      public function getFrameBodyPartOffset(param1:IActiveActionData, param2:int, param3:int, param4:String) : Point
      {
         var _loc5_:AnimationAction = UnknownVarFromAvatarStructure_AnimationData_1.getAction(param1.definition);
         if(_loc5_)
         {
            return _loc5_.getFrameBodyPartOffset(param2,param3,param4);
         }
         return AnimationAction.DEFAULT_OFFSET;
      }
      
      public function getParts(param1:String, param2:IAvatarFigureContainer, param3:IActiveActionData, param4:String, param5:int, param6:Array, param7:IAvatarImage_2, param8:Map = null) : Vector.<AvatarImagePartContainer>
      {
         var _loc37_:Animation = null;
         var _loc26_:* = null;
         var _loc28_:PartDefinition = null;
         var _loc27_:String = null;
         var _loc47_:* = null;
         var _loc14_:GeometryBodyPart = null;
         var _loc30_:* = null;
         var _loc41_:* = null;
         var _loc23_:AvatarImagePartContainer = null;
         var _loc21_:AnimationActionPart = null;
         var _loc45_:* = null;
         var _loc48_:int = 0;
         var _loc15_:Array = null;
         var _loc36_:ISetType = null;
         var _loc24_:IPalette = null;
         var _loc17_:IFigurePartSet = null;
         var _loc18_:* = null;
         var _loc43_:IActionDefinition = null;
         var _loc34_:String = null;
         var _loc10_:IPartColor = null;
         var _loc29_:* = false;
         var _loc13_:* = null;
         var _loc19_:Boolean = false;
         var _loc39_:IPartColor = null;
         var _loc22_:Boolean = false;
         var _loc31_:String = null;
         var _loc44_:int = 0;
         var _loc32_:int = 0;
         var _loc25_:GeometryBodyPart = null;
         var _loc11_:Boolean = false;
         var _loc12_:Number = NaN;
         var _loc42_:String = null;
         var _loc16_:AddDataContainer = null;
         if(param3 == null)
         {
            return null;
         }
         var _loc9_:Array = UnknownVarFromAvatarStructure_PartSetsData_1.getActiveParts(param3.definition);
         var _loc46_:Array = [];
         var _loc35_:Array = [0];
         var _loc38_:AnimationAction = UnknownVarFromAvatarStructure_AnimationData_1.getAction(param3.definition);
         if(param3.definition.isAnimation)
         {
            _loc27_ = param3.definition.state + "." + param3.actionParameter;
            _loc37_ = _animationManager.getAnimation(_loc27_) as Animation;
            if(_loc37_ != null)
            {
               _loc35_ = getPopulatedArray(_loc37_.frameCount(param3.overridingAction));
               for each(_loc47_ in _loc37_.getAnimatedBodyPartIds(0,param3.overridingAction))
               {
                  if(_loc47_ == param1)
                  {
                     _loc14_ = _geometry.getBodyPart(param4,_loc47_);
                     if(_loc14_ != null)
                     {
                        for each(_loc30_ in _loc14_.getDynamicParts(param7))
                        {
                           _loc9_.push(_loc30_.id);
                        }
                     }
                  }
               }
            }
         }
         var _loc20_:Array = _geometry.getParts(param4,param1,param5,_loc9_,param7);
         var _loc33_:Array = param2.getPartTypeIds();
         for each(_loc41_ in _loc33_)
         {
            if(param8 != null)
            {
               if(param8[_loc41_] != null)
               {
                  continue;
               }
            }
            _loc48_ = param2.getPartSetId(_loc41_);
            _loc15_ = param2.getPartColorIds(_loc41_);
            _loc36_ = _figureData.getSetType(_loc41_);
            if(_loc36_)
            {
               _loc24_ = _figureData.getPalette(_loc36_.paletteID);
               if(_loc24_)
               {
                  _loc17_ = _loc36_.getPartSet(_loc48_);
                  if(_loc17_)
                  {
                     param6 = param6.concat(_loc17_.hiddenLayers);
                     for each(_loc18_ in _loc17_.parts)
                     {
                        if(_loc20_.indexOf(_loc18_.type) > -1)
                        {
                           if(_loc38_ != null)
                           {
                              _loc21_ = _loc38_.getPart(_loc18_.type);
                              if(_loc21_ != null)
                              {
                                 _loc45_ = _loc21_.frames;
                              }
                              else
                              {
                                 _loc45_ = _loc35_;
                              }
                           }
                           else
                           {
                              _loc45_ = _loc35_;
                           }
                           _loc43_ = param3.definition;
                           if(_loc9_.indexOf(_loc18_.type) == -1)
                           {
                              _loc43_ = param3.definition.geometryType == "horizontal" ? _defaultLayActionDefinition : _defaultAction;
                           }
                           _loc28_ = UnknownVarFromAvatarStructure_PartSetsData_1.getPartDefinition(_loc18_.type);
                           _loc34_ = _loc28_ == null ? _loc18_.type : _loc28_.flippedSetType;
                           if(_loc34_ == "")
                           {
                              _loc34_ = _loc18_.type;
                           }
                           if(_loc15_ && _loc15_.length > _loc18_.colorLayerIndex - 1)
                           {
                              _loc10_ = _loc24_.getColor(_loc15_[_loc18_.colorLayerIndex - 1]);
                           }
                           _loc29_ = _loc18_.colorLayerIndex > 0;
                           _loc23_ = new AvatarImagePartContainer(param1,_loc18_.type,_loc18_.id.toString(),_loc10_,_loc45_,_loc43_,_loc29_,_loc18_.paletteMap,_loc34_);
                           _loc46_.push(_loc23_);
                        }
                     }
                  }
               }
            }
         }
         var _loc40_:Vector.<AvatarImagePartContainer> = new Vector.<AvatarImagePartContainer>();
         for each(_loc26_ in _loc20_)
         {
            _loc19_ = false;
            _loc39_ = null;
            _loc22_ = param8 && param8[_loc26_];
            for each(_loc13_ in _loc46_)
            {
               if(_loc13_.partType == _loc26_)
               {
                  if(_loc22_)
                  {
                     _loc39_ = _loc13_.color;
                  }
                  else
                  {
                     _loc19_ = true;
                     if(param6.indexOf(_loc26_) == -1)
                     {
                        _loc40_.push(_loc13_);
                     }
                  }
               }
            }
            if(!_loc19_)
            {
               if(_loc22_)
               {
                  _loc31_ = param8[_loc26_];
                  _loc44_ = 0;
                  _loc32_ = 0;
                  while(_loc32_ < _loc31_.length)
                  {
                     _loc44_ += _loc31_.charCodeAt(_loc32_);
                     _loc32_++;
                  }
                  if(_loc38_ != null)
                  {
                     _loc21_ = _loc38_.getPart(_loc26_);
                     if(_loc21_ != null)
                     {
                        _loc45_ = _loc21_.frames;
                     }
                     else
                     {
                        _loc45_ = _loc35_;
                     }
                  }
                  else
                  {
                     _loc45_ = _loc35_;
                  }
                  _loc23_ = new AvatarImagePartContainer(param1,_loc26_,_loc31_,_loc39_,_loc45_,param3.definition,_loc39_ != null,-1,_loc26_,false,1);
                  _loc40_.push(_loc23_);
               }
               else if(_loc9_.indexOf(_loc26_) > -1)
               {
                  _loc25_ = _geometry.getBodyPartOfItem(param4,_loc26_,param7);
                  if(param1 == _loc25_.id)
                  {
                     _loc28_ = UnknownVarFromAvatarStructure_PartSetsData_1.getPartDefinition(_loc26_);
                     _loc11_ = false;
                     _loc12_ = 1;
                     if(_loc28_.appendToFigure)
                     {
                        _loc42_ = "1";
                        if(param3.actionParameter != "")
                        {
                           _loc42_ = param3.actionParameter;
                        }
                        if(_loc28_.hasStaticId())
                        {
                           _loc42_ = _loc28_.staticId.toString();
                        }
                        if(_loc37_ != null)
                        {
                           _loc16_ = _loc37_.getAddData(_loc26_);
                           if(_loc16_ != null)
                           {
                              _loc11_ = _loc16_.isBlended;
                              _loc12_ = _loc16_.blend;
                           }
                        }
                        if(_loc38_ != null)
                        {
                           _loc21_ = _loc38_.getPart(_loc26_);
                           if(_loc21_ != null)
                           {
                              _loc45_ = _loc21_.frames;
                           }
                           else
                           {
                              _loc45_ = _loc35_;
                           }
                        }
                        else
                        {
                           _loc45_ = _loc35_;
                        }
                        _loc23_ = new AvatarImagePartContainer(param1,_loc26_,_loc42_,null,_loc45_,param3.definition,false,-1,_loc26_,_loc11_,_loc12_);
                        _loc40_.push(_loc23_);
                     }
                  }
               }
            }
         }
         return _loc40_;
      }
      
      public function get figureData() : IFigureSetData
      {
         return _figureData;
      }
      
      public function get animationManager() : AnimationManager
      {
         return _animationManager;
      }
      
      public function get renderManager() : AvatarRenderManager
      {
         return _renderManager;
      }
      
      private function getPopulatedArray(param1:int) : Array
      {
         var _loc3_:int = 0;
         var _loc2_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < param1)
         {
            _loc2_.push(_loc3_);
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function displayGeometry(param1:Stage) : void
      {
         var _loc7_:GeometryBodyPart = null;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc14_:Shape = null;
         var _loc4_:BitmapData = new BitmapData(960,540,false,4294967295);
         var _loc10_:Bitmap = new Bitmap(_loc4_);
         param1.addChild(_loc10_);
         var _loc3_:Number = _loc4_.width / 2;
         var _loc2_:Number = _loc4_.height / 2;
         var _loc5_:Number = 200;
         var _loc13_:TextField = new TextField();
         var _loc6_:Matrix = new Matrix();
         for each(var _loc8_ in _geometry.getBodyPartIdsInAvatarSet("full"))
         {
            _loc7_ = _geometry.getBodyPart("vertical",_loc8_);
            Logger.log("Drawing bodypart : " + _loc8_);
            if(_loc7_ != null)
            {
               _loc11_ = _loc7_.location.x * _loc5_;
               _loc12_ = _loc7_.location.z * _loc5_;
               _loc9_ = _loc7_.radius * _loc5_;
               _loc14_ = new Shape();
               _loc14_.graphics.lineStyle(1,4294901760,1);
               _loc14_.graphics.drawCircle(_loc3_ + _loc11_,_loc2_ + _loc12_,_loc9_);
               _loc4_.draw(_loc14_);
               _loc13_.text = _loc8_;
               _loc13_.textColor = 4294901760;
               _loc6_.identity();
               _loc6_.tx = _loc3_ + _loc11_ + _loc9_ - _loc13_.textWidth - 5;
               _loc6_.ty = _loc2_ + _loc12_ - 5;
               _loc4_.draw(_loc13_,_loc6_);
            }
            else
            {
               Logger.log("Could not draw bodypart : " + _loc8_);
            }
         }
      }
      
      public function getItemIds() : Array
      {
         var _loc2_:Dictionary = null;
         var _loc1_:Array = null;
         if(UnknownVarFromAvatarStructure_AvatarActionManager_1)
         {
            _loc2_ = UnknownVarFromAvatarStructure_AvatarActionManager_1.getActionDefinition("CarryItem").params;
            _loc1_ = [];
            for(var _loc3_ in _loc2_)
            {
               _loc1_.push(_loc3_);
            }
            return _loc1_;
         }
         return [];
      }
   }
}

