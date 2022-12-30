
export \
    ANSIBLE_IMG_NAME=$(make ansible-img-name) \
    PROJECT_ROOT=$(make project-root)

function run-container() {
    docker \
        run \
        --interactive \
        --net=host \
        --tty \
        --rm \
        --volume ${PROJECT_ROOT}:${PROJECT_ROOT} \
        --workdir=${PROJECT_ROOT} \
        "${ANSIBLE_IMG_NAME}" \
        ${*}
}