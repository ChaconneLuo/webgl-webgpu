export const WebGLSupport = (): boolean => {
    try {
        const canvas = document.createElement('canvas');
        return !!(window.WebGLRenderingContext && (canvas.getContext('webgl') || canvas.getContext('experimental-webgl')));
    } catch (e) {
        return false;
    }
}
export const WebGL2Support = (): boolean => {
    try {
        const canvas = document.createElement('canvas');
        return !!(window.WebGLRenderingContext && (canvas.getContext('webgl2')));
    } catch (e) {
        return false;
    }
}

export const initWebGLContext = (ref: HTMLCanvasElement): WebGLRenderingContext | WebGL2RenderingContext => {
    let webGLContext: WebGLRenderingContext | WebGL2RenderingContext | RenderingContext | null = null;
    if (WebGL2Support()) {
        webGLContext = ref.getContext('webgl2');
    } else if (WebGLSupport()) {
        webGLContext = ref.getContext('webgl');
    }
    if (!webGLContext) {
        throw new Error('WebGL is not supported');
    }
    return webGLContext;
}

export const createProgram = (gl: WebGLRenderingContext | WebGL2RenderingContext, vertShaderSource: string, fragShaderSource: string,) => {
    const vertShader = gl.createShader(gl.VERTEX_SHADER)!;
    gl.shaderSource(vertShader, vertShaderSource);
    gl.compileShader(vertShader);
    if (!gl.getShaderParameter(vertShader, gl.COMPILE_STATUS)) {
        throw new Error(
            'Vertex Shader Compile Error, Error Log:' +
            gl.getShaderInfoLog(vertShader),
        );
    }

    const fragShader = gl.createShader(gl.FRAGMENT_SHADER)!;
    gl.shaderSource(fragShader, fragShaderSource);
    gl.compileShader(fragShader);

    if (!gl.getShaderParameter(fragShader, gl.COMPILE_STATUS)) {
        throw new Error(
            'Fragmeng Shader Compile Error, Error Log:' +
            gl.getShaderInfoLog(fragShader),
        );
    }

    const program = gl.createProgram()!;
    gl.attachShader(program, vertShader);
    gl.attachShader(program, fragShader);
    gl.linkProgram(program);

    if (!gl.getProgramParameter(program, gl.LINK_STATUS)) {
        throw new Error(
            'Shader Program Link Error, Error Log:' + gl.getProgramInfoLog(program),
        );
    }

    gl.deleteShader(vertShader);
    gl.deleteShader(fragShader);

    return program;
}