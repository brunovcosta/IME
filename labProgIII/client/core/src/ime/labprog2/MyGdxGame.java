package ime.labprog2;

import com.badlogic.gdx.ApplicationAdapter;
import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.graphics.GL20;
import com.badlogic.gdx.graphics.Texture;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.badlogic.gdx.graphics.glutils.ShapeRenderer;
import com.badlogic.gdx.graphics.glutils.ShapeRenderer.ShapeType;

public class MyGdxGame extends ApplicationAdapter {
	SpriteBatch batch;
	ShapeRenderer sr;

	@Override
	public void create () {
		batch = new SpriteBatch();
		sr = new ShapeRenderer();
	}

	@Override
	public void render () {
		int x=10;
		int y=20;
		int x2=30;
		int y2=40;
		int radius=5;
		int height=50;
		int width=60;
		Gdx.gl.glClearColor(0, 0, 0, 1);
		Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT);
		sr.begin(ShapeType.Line);
		sr.setColor(1, 1, 0, 1);
		sr.line(x, y, x2, y2);
		sr.rect(x, y, width, height);
		sr.circle(x, y, radius);
		sr.end();
	}

	@Override
	public void dispose () {
		batch.dispose();
		sr.dispose();
	}
}
