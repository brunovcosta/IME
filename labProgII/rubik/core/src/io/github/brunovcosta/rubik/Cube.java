package io.github.brunovcosta.rubik;

import com.badlogic.gdx.ApplicationAdapter;
import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.Input;
import com.badlogic.gdx.graphics.Color;
import com.badlogic.gdx.graphics.GL20;
import com.badlogic.gdx.graphics.PerspectiveCamera;
import com.badlogic.gdx.graphics.VertexAttributes.Usage;
import com.badlogic.gdx.graphics.g2d.BitmapFont;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.badlogic.gdx.graphics.g3d.Environment;
import com.badlogic.gdx.graphics.g3d.Model;
import com.badlogic.gdx.graphics.g3d.ModelBatch;
import com.badlogic.gdx.graphics.g3d.ModelInstance;
import com.badlogic.gdx.graphics.g3d.attributes.ColorAttribute;
import com.badlogic.gdx.graphics.g3d.environment.DirectionalLight;
import com.badlogic.gdx.graphics.g3d.Material;
import com.badlogic.gdx.graphics.Mesh;
import com.badlogic.gdx.graphics.VertexAttributes;
import com.badlogic.gdx.graphics.VertexAttribute;
import com.badlogic.gdx.graphics.g3d.utils.CameraInputController;
import com.badlogic.gdx.graphics.g3d.utils.ModelBuilder;
import com.badlogic.gdx.graphics.g3d.utils.MeshBuilder;
import com.badlogic.gdx.math.Vector3;
import com.badlogic.gdx.math.Vector2;
import com.badlogic.gdx.graphics.g3d.model.data.ModelMesh;
import com.badlogic.gdx.graphics.g3d.model.data.ModelData;
import com.badlogic.gdx.math.Quaternion;
import com.badlogic.gdx.math.Matrix4;
import com.badlogic.gdx.graphics.glutils.ShapeRenderer;
import com.badlogic.gdx.graphics.glutils.ShapeRenderer.ShapeType;
import java.util.ArrayList;

public class Cube{
	public ModelBatch modelBatch;
	public Model model;
	public ModelInstance[] instances;
	public Vector3[] initialPositions;

	public ArrayList<Vector3> queue;

	public Cube(){
		queue = new ArrayList<Vector3>();

		modelBatch = new ModelBatch();
		ModelBuilder modelBuilder = new ModelBuilder();
		float size = 5f;
		modelBuilder.begin();
		MeshBuilder meshBuilder = new MeshBuilder();
		meshBuilder.begin(VertexAttributes.Usage.Position | VertexAttributes.Usage.TextureCoordinates | VertexAttributes.Usage.ColorPacked | VertexAttributes.Usage.Normal, GL20.GL_TRIANGLES);
		meshBuilder.setColor(Color.RED);
		meshBuilder.rect(
				new Vector3(-size,+size,+size),
				new Vector3(-size,-size,+size),
				new Vector3(+size,-size,+size),
				new Vector3(+size,+size,+size),
				new Vector3(0,0,1));
		meshBuilder.setColor(Color.BLUE);
		meshBuilder.rect(
				new Vector3(+size,+size,+size),
				new Vector3(+size,+size,-size),
				new Vector3(-size,+size,-size),
				new Vector3(-size,+size,+size),
				new Vector3(0,1,0));
		meshBuilder.setColor(Color.YELLOW);
		meshBuilder.rect(
				new Vector3(+size,+size,+size),
				new Vector3(+size,-size,+size),
				new Vector3(+size,-size,-size),
				new Vector3(+size,+size,-size),
				new Vector3(1,0,0));
		meshBuilder.setColor(Color.ORANGE);
		meshBuilder.rect(
				new Vector3(+size,+size,-size),
				new Vector3(+size,-size,-size),
				new Vector3(-size,-size,-size),
				new Vector3(-size,+size,-size),
				new Vector3(0,0,-1));
		meshBuilder.setColor(Color.GREEN);
		meshBuilder.rect(
				new Vector3(-size,-size,+size),
				new Vector3(-size,-size,-size),
				new Vector3(+size,-size,-size),
				new Vector3(+size,-size,+size),
				new Vector3(0,-1,0));
		meshBuilder.setColor(Color.WHITE);
		meshBuilder.rect(
				new Vector3(-size,+size,-size),
				new Vector3(-size,-size,-size),
				new Vector3(-size,-size,+size),
				new Vector3(-size,+size,+size),
				new Vector3(-1,0,0));
		Mesh faces = meshBuilder.end();
		modelBuilder.part("cube", faces, GL20.GL_TRIANGLES, new Material());
		model = modelBuilder.end();

		instances = new ModelInstance[27];
		initialPositions = new Vector3[27];
		for(int i=-1;i<=1;i++){
			for(int j=-1;j<=1;j++){
				for(int k=-1;k<=1;k++){
					int pos = (i+1)*1+(j+1)*3+(k+1)*9;
					initialPositions[pos]=new Vector3(2*size*i,2*size*j,2*size*k);
					instances[pos] = new ModelInstance(model,initialPositions[pos]);
				}
			}
		}
	}

	public void render(Environment environment,PerspectiveCamera cam){
		float angle = 10;
		if(queue.isEmpty()){
			if(
				Gdx.input.justTouched() &&
				new Vector2(Gdx.input.getX(),Gdx.input.getY()).sub(new Vector2(Gdx.graphics.getWidth()/2,Gdx.graphics.getHeight()/2)).len()>Gdx.graphics.getHeight()/4
			){
				for(int i=0;i<90/angle;i++){
					queue.add( VectorHelper.snapToGrid(
						cam.unproject(new Vector3(Gdx.input.getX(),Gdx.input.getY(),0))
						.sub(cam.unproject(new Vector3(Gdx.graphics.getWidth()/2,Gdx.graphics.getHeight()/2,0)))
					));
				}

			}
		}else{
			move(queue.get(queue.size()-1),angle,cam);
			queue.remove(queue.size()-1);
		}


		if(!Gdx.input.isKeyPressed(Input.Keys.SPACE)){
			modelBatch.begin(cam);
			for(ModelInstance instance : instances)
				modelBatch.render(instance, environment);
			modelBatch.end();
		}else{
			//debug render
			ShapeRenderer shapeRenderer = new ShapeRenderer();
			shapeRenderer.setProjectionMatrix(cam.combined);
			shapeRenderer.begin(ShapeType.Line);
			shapeRenderer.setColor(Color.RED);
			shapeRenderer.line(new Vector3(),new Vector3(1,0,0));
			shapeRenderer.setColor(Color.GREEN);
			shapeRenderer.line(new Vector3(),new Vector3(0,1,0));
			shapeRenderer.setColor(Color.BLUE);
			shapeRenderer.line(new Vector3(),new Vector3(0,0,1));
			shapeRenderer.setColor(Color.WHITE);
			shapeRenderer.line(new Vector3(),cam.unproject(new Vector3(Gdx.input.getX(),Gdx.input.getY(),0)));
			shapeRenderer.setColor(Color.PINK);
			shapeRenderer.line(new Vector3(),VectorHelper.snapToGrid(cam.direction));
			shapeRenderer.setColor(Color.PURPLE);
			shapeRenderer.line(
					new Vector3(),
					VectorHelper.snapToGrid(
						cam.unproject(new Vector3(Gdx.input.getX(),Gdx.input.getY(),0))
						.sub(cam.unproject(new Vector3(Gdx.graphics.getWidth()/2,Gdx.graphics.getHeight()/2,0)))
						)
					);
			shapeRenderer.end();

			BitmapFont font = new BitmapFont(Gdx.files.internal("font.bmp"), false);
			SpriteBatch batch=new SpriteBatch();
			batch.begin();
			font.draw(batch, "hello", 12,34);
			batch.end();
		}
	}

	//rotate the axis pointed in angle
	public void move(Vector3 axis,float degree,PerspectiveCamera cam){
		int t=0;
		for(ModelInstance instance : instances){
			Vector3 pos = instance.transform.getTranslation(new Vector3());
			if( pos.x*axis.x>0.01 || pos.y*axis.y>0.01 || pos.z*axis.z>0.01){
				Vector3 ipos = initialPositions[t];
				Matrix4 inv = new Matrix4(instance.transform).inv();

				instance.transform
					.translate(new Vector3(-ipos.x,-ipos.y,-ipos.z))
					.rotate(new Vector3(axis).rot(inv),degree)
					.translate(new Vector3(ipos.x,ipos.y,ipos.z));
			}
			t++;
		}
	}
}
